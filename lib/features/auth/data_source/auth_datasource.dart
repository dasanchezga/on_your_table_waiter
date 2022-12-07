import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_core/external/api_handler.dart';
import 'package:oyt_front_core/external/db_handler.dart';
import 'package:oyt_front_core/logger/logger.dart';
import 'package:on_your_table_waiter/features/auth/models/check_waiter_response.dart';

final waiterAuthDatasourceProvider = Provider<WaiterAuthDataSource>((ref) {
  return WaiterAuthDatasourceImpl.fromRead(ref);
});

abstract class WaiterAuthDataSource {
  Future<CheckWaiterResponse> checkIfIsWaiter();
}

class WaiterAuthDatasourceImpl implements WaiterAuthDataSource {
  factory WaiterAuthDatasourceImpl.fromRead(Ref ref) {
    final apiHandler = ref.read(apiHandlerProvider);
    final dbHandler = ref.read(dbHandlerProvider);
    return WaiterAuthDatasourceImpl(apiHandler, dbHandler);
  }

  const WaiterAuthDatasourceImpl(this.apiHandler, this.dbHandler);

  final ApiHandler apiHandler;
  final DBHandler dbHandler;

  @override
  Future<CheckWaiterResponse> checkIfIsWaiter() async {
    try {
      final res = await apiHandler.get('/auth/is-waiter');
      return CheckWaiterResponse.fromMap(res.responseMap!);
    } catch (e, s) {
      Logger.logError(e.toString(), s);
      rethrow;
    }
  }
}
