import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/core/constants/socket_constants.dart';
import 'package:on_your_table_waiter/core/external/socket_handler.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:on_your_table_waiter/core/validators/text_form_validator.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/features/table/models/change_table_status.dart';
import 'package:on_your_table_waiter/features/table/models/customer_requests_response.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/features/table/models/users_table.dart';
import 'package:on_your_table_waiter/features/table/provider/table_state.dart';
import 'package:on_your_table_waiter/ui/menu/index_menu_screen.dart';
import 'package:on_your_table_waiter/ui/widgets/snackbar/custom_snackbar.dart';

final tableProvider = StateNotifierProvider<TableProvider, TableState>((ref) {
  return TableProvider.fromRead(ref);
});

class TableProvider extends StateNotifier<TableState> {
  TableProvider(this.socketIOHandler, {required this.ref}) : super(TableState.initial());

  factory TableProvider.fromRead(Ref ref) {
    final socketIo = ref.read(socketProvider);
    return TableProvider(socketIo, ref: ref);
  }

  final Ref ref;
  final SocketIOHandler socketIOHandler;

  Future<void> onReadTableCode(String code) async {
    final validationError = TextFormValidator.tableCodeValidator(code);
    if (validationError != null) {
      CustomSnackbar.showSnackBar(ref.read(routerProvider).context, validationError);
      return;
    }
    GoRouter.of(ref.read(routerProvider).context).go('${IndexHomeScreen.route}?tableId=$code');
  }

  void startListeningSocket() {
    listenTables();
    joinToRestaurant();
    listenCustomerRequests();
  }

  void listenCustomerRequests() {
    socketIOHandler.onMap(SocketConstants.customerRequests, (data) {
      final res = CustomerRequestsResponse.fromMap(data);
      state = state.copyWith(customerRequests: StateAsync.success(res));
    });
  }

  Future<void> listenTables() async {
    socketIOHandler.onMap(SocketConstants.listenTables, (data) {
      state = state.copyWith(
        tables: StateAsync.success(TablesSocketResponse.fromList(data['tables'])),
      );
    });
  }

  Future<void> joinToRestaurant() async {
    final restaurantId = ref.read(authProvider).checkWaiterResponse.data?.restaurantId;
    socketIOHandler.emitMap(SocketConstants.joinToRestaurant, {
      'token': ref.read(authProvider).authModel.data?.bearerToken ?? '',
      'restaurantId': restaurantId,
    });
  }

  Future<void> changeStatus(TableStatus status, TableResponse table) async {
    socketIOHandler.emitMap(
      SocketConstants.changeTableStatus,
      ChangeTableStatus(
        tableId: table.id,
        token: ref.read(authProvider).authModel.data?.bearerToken ?? '',
        status: status,
      ).toMap(),
    );
  }

  void joinToTable(TableResponse table) {
    socketIOHandler.on(SocketConstants.watchATable, (data) {
      print(data);
    });
    socketIOHandler.emitMap(SocketConstants.watchTable, {
      'token': ref.read(authProvider).authModel.data?.bearerToken ?? '',
      'tableId': table.id,
    });
  }

  void leaveTable(TableResponse table) {
    socketIOHandler.emitMap(SocketConstants.leaveTable, {'tableId': table.id});
  }
}
