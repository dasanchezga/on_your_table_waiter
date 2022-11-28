class SocketConstants {
  static const joinSocket = 'table:join';
  static const onNewUserJoined = 'new_user_joined';
  static const addToOrder = 'order:add-item';
  static const listOfOrders = 'list_of_orders';
  static const callWaiter = 'table:call-waiter';
  static const stopCallWaiter = 'table:stop-calling-waiter';
  static const changeTableStatus = 'table:change-status';
  static const deleteItem = 'order:delete-item';
  static const editItem = 'order:edit-item';

  //WAITER
  static const addToOrderToUser = 'waiter:add-item-to-table';
  static const joinToRestaurant = 'restaurant:join';
  static const listenTables = 'restaurant:tables';
  static const customerRequests = 'customer_requests';
  static const watchTable = 'waiter:watch-table';
  static const watchATable = 'watch-table';
  static const leaveTable = 'waiter:leave-table';
  static const orderQueue = 'order_queue';
}
