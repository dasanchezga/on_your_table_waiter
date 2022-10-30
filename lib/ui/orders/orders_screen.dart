import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
   final List<dynamic> items = ["Sushi pizza","Ninja Roll","Soto de Salmon","Coctel de camarón", "Calamar tempura","Langostinos rebozados", "Tuna tataki"];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PEDIDOS'),shadowColor: Colors.red,),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 5,
        itemBuilder:(context,index){
          items.shuffle();
          return Container(
            height: 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                ('assets/images/2.jpg'),
                ),
                alignment: Alignment.topLeft,
              )
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text('Pedido:  ${items[index]}',
               style: const TextStyle(
                color: Colors.black,
                fontSize: 15
               )
              ) 
            )
          );
        } 
      )
    );     
  }
}