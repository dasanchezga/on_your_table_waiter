import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/features/orders_queue/provider/orders_queue_provider.dart';

class ProductsMenuScreen extends ConsumerWidget {
  const ProductsMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersQueueState = ref.watch(ordersQueueProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text('Productos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('Aca puedes ver la cola de productos con sus estados...'),
          const SizedBox(height: 20),
          ordersQueueState.ordersQueue.on(
            onError: (err) => Center(child: Text(err.message)),
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onInitial: () => const Center(child: Text('No hay productos en cola')),
            onData: (data) => data.isEmpty
                ? const Center(child: Text('No hay productos en cola'))
                : Column(
                    children: data
                        .map(
                          (e) => Card(
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              horizontalTitleGap: 10,
                              title: Text('Producto: ${e.productName}'),
                              subtitle: Text('Mesa: ${e.tableName}'),
                              trailing: Text('Estado: \n${e.estado}'),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
