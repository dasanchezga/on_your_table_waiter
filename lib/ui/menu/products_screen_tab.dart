import 'package:flutter/material.dart';

class ProductsMenuScreen extends StatelessWidget {
  const ProductsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text('Productos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('Aca puedes ver la cola de productos con sus estados...'),
          const SizedBox(height: 20),
          ...List.generate(
            10,
            (index) => Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                horizontalTitleGap: 10,
                title: Text('Producto $index'),
                subtitle: Text('Estado: $index'),
                trailing: Text('Mesa $index'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
