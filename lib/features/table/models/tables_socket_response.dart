import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:on_your_table_waiter/features/table/models/users_table.dart';

class TablesSocketResponse extends Equatable {
  const TablesSocketResponse({required this.tables});

  final List<TableResponse> tables;

  TablesSocketResponse copyWith({
    List<TableResponse>? tables,
  }) {
    return TablesSocketResponse(
      tables: tables ?? this.tables,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tables': tables.map((x) => x.toMap()).toList(),
    };
  }

  factory TablesSocketResponse.fromList(List list) {
    return TablesSocketResponse(
      tables: List<TableResponse>.from(list.map((x) => TableResponse.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'TablesSocketResponse(tables: $tables)';

  @override
  List<Object> get props => [tables];
}

class TableResponse extends Equatable {
  const TableResponse({
    required this.id,
    required this.name,
    required this.status,
  });

  final String id;
  final String name;
  final TableStatus status;

  TableResponse copyWith({
    String? id,
    String? name,
    TableStatus? status,
  }) {
    return TableResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'status': status.value,
    };
  }

  factory TableResponse.fromMap(Map<String, dynamic> map) {
    return TableResponse(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      status: TableStatus.fromString(map['status'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory TableResponse.fromJson(String source) => TableResponse.fromMap(json.decode(source));

  @override
  String toString() => 'TableResponse(id: $id, name: $name, status: $status)';

  @override
  List<Object> get props => [id, name, status];
}
