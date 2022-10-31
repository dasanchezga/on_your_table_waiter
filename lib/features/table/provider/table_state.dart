import 'package:equatable/equatable.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/table/models/tables_socket_response.dart';

class TableState extends Equatable {
  const TableState(this.tables);

  factory TableState.initial() {
    return TableState(StateAsync.initial());
  }

  final StateAsync<TablesSocketResponse> tables;

  TableState copyWith({
    StateAsync<TablesSocketResponse>? tables,
  }) {
    return TableState(
      tables ?? this.tables,
    );
  }

  @override
  List<Object?> get props => [tables];
}
