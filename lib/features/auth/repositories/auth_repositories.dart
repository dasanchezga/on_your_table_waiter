import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oyt_front_auth/data_source/auth_datasource.dart';
import 'package:oyt_front_core/failure/failure.dart';
import 'package:on_your_table_waiter/features/auth/data_source/auth_datasource.dart';
import 'package:on_your_table_waiter/features/auth/models/check_waiter_response.dart';
import 'package:oyt_front_auth/repositories/auth_repositories.dart';

final authRepositoryProvider = Provider<WaiterAuthRepository>((ref) {
  return WaiterAuthRepository.fromRead(ref);
});

class WaiterAuthRepository extends AuthRepositoryImpl {
  WaiterAuthRepository({required this.waiterAuthDatasource, required super.authDatasource});

  factory WaiterAuthRepository.fromRead(Ref ref) {
    final waiterAuthDatasource = ref.read(waiterAuthDatasourceProvider);
    final authDatasource = ref.read(authDatasourceProvider);
    return WaiterAuthRepository(
      waiterAuthDatasource: waiterAuthDatasource,
      authDatasource: authDatasource,
    );
  }

  final WaiterAuthDataSource waiterAuthDatasource;

  Future<Either<Failure, CheckWaiterResponse>> checkIfIsWaiter() async {
    try {
      final res = await waiterAuthDatasource.checkIfIsWaiter();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
