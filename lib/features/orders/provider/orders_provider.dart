import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/constants/socket_constants.dart';
import 'package:oyt_front_core/external/socket_handler.dart';
import 'package:oyt_front_core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/features/orders/models/users_by_table.dart';
import 'package:on_your_table_waiter/features/orders/provider/order_state.dart';
import 'package:on_your_table_waiter/features/orders/repository/orders_repository.dart';
import 'package:on_your_table_waiter/features/product/models/product_model.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';
import 'package:uuid/uuid.dart';

final ordersProvider = StateNotifierProvider<OrdersProvider, OrderState>((ref) {
  return OrdersProvider.fromRef(ref);
});

class OrdersProvider extends StateNotifier<OrderState> {
  OrdersProvider(this.ordersRepository, this.socketIOHandler, this.ref)
      : super(OrderState.initial());

  factory OrdersProvider.fromRef(Ref ref) {
    final ordersRepository = ref.read(ordersRepositoryProvider);
    final socketIOHandler = ref.read(socketProvider);
    return OrdersProvider(ordersRepository, socketIOHandler, ref);
  }

  final OrdersRepository ordersRepository;
  final SocketIOHandler socketIOHandler;
  final Ref ref;

  Future<void> addProductToUser(
    TableResponse table,
    UsersByTable? user,
    ProductDetailModel product,
  ) async {
    socketIOHandler.emitMap(SocketConstants.addToOrderToUser, {
      ...product.toJson(),
      'tableId': table.id,
      'clientId': user?.userid,
      'uuid': const Uuid().v4(),
      'token': ref.read(authProvider).authModel.data?.bearerToken ?? '',
    });
  }

  Future<void> getOrders() async {
    state = state.copyWith(orders: StateAsync.loading());
    final orders = await ordersRepository.getOrders();
    orders.fold(
      (l) => state = state.copyWith(orders: StateAsync.error(l)),
      (r) => state = state.copyWith(orders: StateAsync.success(r)),
    );
  }

  Future<void> getOrderById(String id) async {
    state = state.copyWith(order: StateAsync.loading());
    final order = await ordersRepository.getOrderById(id);
    order.fold(
      (l) => state = state.copyWith(order: StateAsync.error(l)),
      (r) => state = state.copyWith(order: StateAsync.success(r)),
    );
  }

  Future<void> getUserByTable(String tableId) async {
    state = state.copyWith(usersByTable: StateAsync.loading());
    final order = await ordersRepository.getUserByTable(tableId);
    order.fold(
      (l) => state = state.copyWith(usersByTable: StateAsync.error(l)),
      (r) => state = state.copyWith(usersByTable: StateAsync.success(r)),
    );
  }
}
