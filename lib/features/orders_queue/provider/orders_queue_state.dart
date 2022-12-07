import 'package:equatable/equatable.dart';

import 'package:oyt_front_core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/orders_queue/models/orders_queue.dart';

class OrdersQueueState extends Equatable {
  final StateAsync<List<OrdersQueueModel>> ordersQueue;

  const OrdersQueueState(this.ordersQueue);

  factory OrdersQueueState.initial() => OrdersQueueState(StateAsync.initial());

  @override
  List<Object?> get props => [ordersQueue];

  OrdersQueueState copyWith({
    StateAsync<List<OrdersQueueModel>>? ordersQueue,
  }) {
    return OrdersQueueState(
      ordersQueue ?? this.ordersQueue,
    );
  }
}
