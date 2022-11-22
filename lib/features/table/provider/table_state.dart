import 'package:equatable/equatable.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/table/models/customer_requests_response.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';
import 'package:on_your_table_waiter/features/table/models/users_table.dart';

class TableState extends Equatable {
  const TableState(
    this.tables,
    this.customerRequests,
    this.tableUsers,
  );

  factory TableState.initial() {
    return TableState(
      StateAsync.initial(),
      StateAsync.initial(),
      StateAsync.initial(),
    );
  }

  final StateAsync<TablesSocketResponse> tables;
  final StateAsync<CustomerRequestsResponse> customerRequests;
  final StateAsync<UsersTable> tableUsers;

  TableState copyWith({
    StateAsync<TablesSocketResponse>? tables,
    StateAsync<CustomerRequestsResponse>? customerRequests,
    StateAsync<UsersTable>? tableUsers,
  }) {
    return TableState(
      tables ?? this.tables,
      customerRequests ?? this.customerRequests,
      tableUsers ?? this.tableUsers,
    );
  }

  @override
  List<Object> get props => [tables, customerRequests, tableUsers];
}
