import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_product/models/product_model.dart';
import 'package:oyt_front_table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/widgets/bottom_sheet/add_product_to_user_sheet.dart';
import 'package:oyt_front_widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:oyt_front_widgets/loading/loading_widget.dart';
import 'package:oyt_front_widgets/widgets/buttons/custom_elevated_button.dart';

class AddOrderToTableSheet extends ConsumerStatefulWidget {
  const AddOrderToTableSheet({required this.product, super.key});

  final ProductDetailModel product;

  static void show(BuildContext context, ProductDetailModel product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => AddOrderToTableSheet(product: product),
    );
  }

  @override
  ConsumerState<AddOrderToTableSheet> createState() => _AddOrderToTableState();
}

class _AddOrderToTableState extends ConsumerState<AddOrderToTableSheet> {
  TableResponse? _selectedTable;

  @override
  Widget build(BuildContext context) {
    final tableState = ref.watch(tableProvider);
    return BaseBottomSheet(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  'Añadir producto a mesa ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 10),
          const Text('Selecciona la mesa al cual se agregue el producto:'),
          tableState.tables.on(
            onError: (error) => Text(error.toString()),
            onLoading: () => const LoadingWidget(),
            onInitial: () => const SizedBox.shrink(),
            onData: (data) => Column(
              children: data.tables
                  .map(
                    (e) => RadioListTile<TableResponse>(
                      value: e,
                      groupValue: _selectedTable,
                      onChanged: (v) => setState(() => _selectedTable = v),
                      title: Text('Mesa: ${e.name}'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: onAddProductToUser,
              child: const Text('Seleccionar usuario'),
            ),
          ),
        ],
      ),
    );
  }

  void onAddProductToUser() {
    if (_selectedTable == null) return;
    Navigator.of(context).pop();
    AddOrderToUserSheet.show(context, _selectedTable!, widget.product);
  }
}
