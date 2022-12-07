import 'package:equatable/equatable.dart';
import 'package:oyt_front_core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/auth/models/auth_model.dart';
import 'package:on_your_table_waiter/features/auth/models/check_waiter_response.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.authModel,
    required this.checkWaiterResponse,
  });

  factory AuthState.initial() {
    return AuthState(
      authModel: StateAsync.initial(),
      checkWaiterResponse: StateAsync.initial(),
    );
  }

  final StateAsync<AuthModel> authModel;
  final StateAsync<CheckWaiterResponse> checkWaiterResponse;

  AuthState copyWith({
    StateAsync<AuthModel>? authModel,
    StateAsync<CheckWaiterResponse>? checkWaiterResponse,
  }) {
    return AuthState(
      authModel: authModel ?? this.authModel,
      checkWaiterResponse: checkWaiterResponse ?? this.checkWaiterResponse,
    );
  }

  @override
  List<Object?> get props => [authModel];
}
