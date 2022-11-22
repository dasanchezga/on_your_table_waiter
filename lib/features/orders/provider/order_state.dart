import 'package:equatable/equatable.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/orders/models/order_complete_response.dart';
import 'package:on_your_table_waiter/features/orders/models/orders_model.dart';
import 'package:on_your_table_waiter/features/orders/models/users_by_table.dart';

class OrderState extends Equatable {
  const OrderState({required this.usersByTable, required this.order, required this.orders});

  factory OrderState.initial() {
    return OrderState(
      order: StateAsync.initial(),
      orders: StateAsync.initial(),
      usersByTable: StateAsync.initial(),
    );
  }

  final StateAsync<Orders> orders;
  final StateAsync<OrderCompleteResponse> order;
  final StateAsync<List<UsersByTable>> usersByTable;

  @override
  List<Object?> get props => [orders, order, usersByTable];

  OrderState copyWith({
    StateAsync<Orders>? orders,
    StateAsync<OrderCompleteResponse>? order,
    StateAsync<List<UsersByTable>>? usersByTable,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      order: order ?? this.order,
      usersByTable: usersByTable ?? this.usersByTable,
    );
  }
}
