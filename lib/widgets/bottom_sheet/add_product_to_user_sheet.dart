import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_order/models/users_by_table.dart';
import 'package:on_your_table_waiter/features/orders/provider/orders_provider.dart';
import 'package:oyt_front_product/models/product_model.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';
import 'package:oyt_front_widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:oyt_front_widgets/bottom_sheet/bottom_sheet_constants.dart';
import 'package:oyt_front_widgets/loading/loading_widget.dart';

class AddOrderToUserSheet extends ConsumerStatefulWidget {
  const AddOrderToUserSheet({required this.table, required this.product, super.key});

  final TableResponse table;
  final ProductDetailModel product;

  static Future<void> show(BuildContext context, TableResponse table, ProductDetailModel product) {
    return showModalBottomSheet(
      context: context,
      shape: BottomSheetConstants.shape,
      builder: (context) => AddOrderToUserSheet(table: table, product: product),
    );
  }

  @override
  ConsumerState<AddOrderToUserSheet> createState() => _AddOrderToUserState();
}

class _AddOrderToUserState extends ConsumerState<AddOrderToUserSheet> {
  UsersByTable? _selectedUser;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersProvider.notifier).getUserByTable(widget.table.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersProvider);
    return BaseBottomSheet(
      title: 'Agregar producto',
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('Selecciona el usuario al cual se agregue el producto:'),
          ordersState.usersByTable.on(
            onError: (error) => Text(error.toString()),
            onLoading: () => const LoadingWidget(),
            onInitial: () => const LoadingWidget(),
            onData: (data) => Column(
              children: data
                  .map(
                    (e) => RadioListTile<UsersByTable>(
                      value: e,
                      groupValue: _selectedUser,
                      onChanged: (v) => setState(() => _selectedUser = v),
                      title: Text('Usuario: ${e.fullName}'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onAddProductToUser,
              child: const Text('Agregar producto'),
            ),
          ),
        ],
      ),
    );
  }

  void onAddProductToUser() {
    if (_selectedUser == null) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
    ref.read(ordersProvider.notifier).addProductToUser(widget.table, _selectedUser, widget.product);
  }
}
