import 'package:equatable/equatable.dart';

import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/table/models/customer_requests_response.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';

class TableState extends Equatable {
  const TableState(
    this.tables,
    this.customerRequests,
  );

  factory TableState.initial() {
    return TableState(StateAsync.initial(), StateAsync.initial());
  }

  final StateAsync<TablesSocketResponse> tables;
  final StateAsync<CustomerRequestsResponse> customerRequests;

  TableState copyWith({
    StateAsync<TablesSocketResponse>? tables,
    StateAsync<CustomerRequestsResponse>? customerRequests,
  }) {
    return TableState(
      tables ?? this.tables,
      customerRequests ?? this.customerRequests,
    );
  }

  @override
  List<Object> get props => [tables, customerRequests];
}
