import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PEDIDOS')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 9,
        itemBuilder:(context, index){
          return Container(
            height: 50,
            color: Colors.grey,
            child: Center(child: Text('Pedido $index'))
          );
        } 
      )  //=> Text('Item $index') ),
    );     
  }
}