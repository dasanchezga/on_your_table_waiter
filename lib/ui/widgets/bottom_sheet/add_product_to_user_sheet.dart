import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/features/table/models/users_table.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:on_your_table_waiter/ui/widgets/buttons/custom_elevated_button.dart';

class AddOrderToProductSheet extends ConsumerStatefulWidget {
  const AddOrderToProductSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => const AddOrderToProductSheet(),
    );
  }

  @override
  ConsumerState<AddOrderToProductSheet> createState() => _ChangeTableStatusSheetState();
}

class _ChangeTableStatusSheetState extends ConsumerState<AddOrderToProductSheet> {
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          const Text('Selecciona el usuario al cual se agregue el producto:'),
          ...TableStatus.values.map(
            (e) => RadioListTile<TableStatus>(
              value: e,
              groupValue: null,
              onChanged: (v) {},
              title: Text('Usuario ${e.index}'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: onAddProductToUser,
              child: const Text('Agregar producto'),
            ),
          ),
        ],
      ),
    );
  }

  void onAddProductToUser() {
    //TODO: CONTINUE onAddProductToUser
  }
}
