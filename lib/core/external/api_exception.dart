import 'package:equatable/equatable.dart';
import 'package:on_your_table_waiter/core/external/api_response.dart';

class ApiException extends Equatable {
  const ApiException(this.response);
  final ApiResponse response;

  @override
  List<Object?> get props => [response];
}
