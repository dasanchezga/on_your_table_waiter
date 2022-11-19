// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/core/external/socket_handler.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_state.dart';
import 'package:on_your_table_waiter/features/auth/repositories/auth_repositories.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/features/user/models/user_model.dart';
import 'package:on_your_table_waiter/ui/error/error_screen.dart';
import 'package:on_your_table_waiter/ui/menu/index_menu_screen.dart';
import 'package:on_your_table_waiter/ui/on_boarding/on_boarding.dart';


final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider.fromRead(ref);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({
    required this.authRepository,
    required this.ref,
    required this.socketIOHandler,
  }) : super(AuthState.initial());

  factory AuthProvider.fromRead(Ref ref) {
    final authRepository = ref.read(authRepositoryProvider);
    final socketIo = ref.read(socketProvider);
    return AuthProvider(
      ref: ref,
      authRepository: authRepository,
      socketIOHandler: socketIo,
    );
  }

  final Ref ref;
  final AuthRepository authRepository;
  final SocketIOHandler socketIOHandler;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(authModel: StateAsync.loading());
    final res = await authRepository.login(email, password);
    res.fold(
      (l) {
        state = state.copyWith(authModel: StateAsync.error(l));
        ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': l.message});
      },
      (r) async {
        await checkIfIsWaiter();
        state = state.copyWith(authModel: StateAsync.success(r));
        ref.read(routerProvider).router.go(IndexHomeScreen.route);
        startListeningSocket();
      },
    );
  }

  Future<void> checkIfIsWaiter() async {
    state = state.copyWith(checkWaiterResponse: StateAsync.loading());
    final res = await authRepository.checkIfIsWaiter();
    res.fold(
      (l) => ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': l.message}),
      (r) => state = state.copyWith(checkWaiterResponse: StateAsync.success(r)),
    );
  }

  Future<void> register(User user, BuildContext context) async {
    state = state.copyWith(authModel: StateAsync.loading());
    final res = await authRepository.register(user);
    if (res != null) {
      state = state.copyWith(authModel: StateAsync.error(res));
      ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': res.message});
      return;
    }
    await login(email: user.email, password: user.password ?? '');
    ref.read(routerProvider).router.pop();
  }

  Future<void> logout() async {
    if (state.authModel.data == null) {
      ref
          .read(routerProvider)
          .router
          .push(ErrorScreen.route, extra: {'error': 'No tienes una sesion activa'});
      return;
    }

    final res = await authRepository.logout();
    if (res != null) {
      state = state.copyWith(authModel: StateAsync.error(res));
      ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': res.message});
      return;
    }
    stopListeningSocket();
    Navigator.of(ref.read(routerProvider).context).popUntil((route) => route.isFirst);
    Navigator.of(ref.read(routerProvider).context).pushReplacementNamed(OnBoarding.route);
    state = AuthState.initial();
  }

  Future<void> restorePassword(String email) async {
    final res = await authRepository.restorePassword(email);
    if (res != null) return;
  }

  Future<void> getUserByToken() async {
    state = state.copyWith(authModel: StateAsync.loading());
    final res = await authRepository.getUserByToken();
    res.fold(
      (l) => state = state.copyWith(authModel: StateAsync.error(l)),
      (r) async {
        if (r == null) {
          state = state.copyWith(authModel: StateAsync.initial());
          return;
        }
        await checkIfIsWaiter();
        startListeningSocket();
        state = state.copyWith(authModel: StateAsync.success(r));
        ref.read(routerProvider).router.go(IndexHomeScreen.route);
      },
    );
  }

  void stopListeningSocket() {
    socketIOHandler.disconnect();
  }

  Future<void> startListeningSocket() async {
    await socketIOHandler.connect();
    ref.read(tableProvider.notifier).startListeningSocket();
  }
}
