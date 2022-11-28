import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrdersQueueModel extends Equatable {
  final String productId;
  final String tableId;
  final String tableName;
  final String productName;
  final String estado;

  const OrdersQueueModel({
    required this.productId,
    required this.tableId,
    required this.tableName,
    required this.productName,
    required this.estado,
  });

  OrdersQueueModel copyWith({
    String? productId,
    String? tableId,
    String? tableName,
    String? productName,
    String? estado,
  }) {
    return OrdersQueueModel(
      productId: productId ?? this.productId,
      tableId: tableId ?? this.tableId,
      tableName: tableName ?? this.tableName,
      productName: productName ?? this.productName,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'tableId': tableId,
      'tableName': tableName,
      'productName': productName,
      'estado': estado,
    };
  }

  factory OrdersQueueModel.fromMap(Map<String, dynamic> map) {
    return OrdersQueueModel(
      productId: map['productId'] ?? '',
      tableId: map['tableId'] ?? '',
      tableName: map['tableName'] ?? '',
      productName: map['productName'] ?? '',
      estado: map['estado'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersQueueModel.fromJson(String source) => OrdersQueueModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrdersQueueModel(productId: $productId, tableId: $tableId, tableName: $tableName, productName: $productName, estado: $estado)';
  }

  @override
  List<Object> get props {
    return [
      productId,
      tableId,
      tableName,
      productName,
      estado,
    ];
  }
}
