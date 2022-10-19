import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:on_your_table_waiter/core/validators/text_form_validator.dart';
import 'package:on_your_table_waiter/features/table/provider/table_state.dart';
import 'package:on_your_table_waiter/ui/menu/index_menu_screen.dart';
import 'package:on_your_table_waiter/ui/on_boarding/on_boarding.dart';
import 'package:on_your_table_waiter/ui/widgets/snackbar/custom_snackbar.dart';

final tableProvider = StateNotifierProvider<TableProvider, TableState>((ref) {
  return TableProvider(ref: ref);
});

class TableProvider extends StateNotifier<TableState> {
  TableProvider({required this.ref}) : super(const TableState());

  final Ref ref;

  Future<void> onReadTableCode(String code) async {
    final validationError = TextFormValidator.tableCodeValidator(code);
    if (validationError != null) {
      CustomSnackbar.showSnackBar(ref.read(routerProvider).context, validationError);
      return;
    }
    GoRouter.of(ref.read(routerProvider).context).go('${IndexMenuScreen.route}?tableId=$code');
  }

  void onClearTableCode() {
    state = state.copyWith(tableCode: null);
  }

  void onSetTableCode(String code) {
    final validationError = TextFormValidator.tableCodeValidator(code);
    if (validationError != null) {
      GoRouter.of(ref.read(routerProvider).context).go(OnBoarding.route);
      CustomSnackbar.showSnackBar(ref.read(routerProvider).context, validationError);
      return;
    }
    state = state.copyWith(tableCode: code);
  }
}
