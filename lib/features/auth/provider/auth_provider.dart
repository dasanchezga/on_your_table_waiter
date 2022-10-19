import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:on_your_table_waiter/core/wrappers/state_wrapper.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_state.dart';
import 'package:on_your_table_waiter/features/auth/repositories/auth_repositories.dart';
import 'package:on_your_table_waiter/features/user/models/user_model.dart';
import 'package:on_your_table_waiter/ui/error/error_screen.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider.fromRead(ref);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({
    required this.authRepository,
    required this.ref,
  }) : super(AuthState(user: StateAsync.initial()));

  factory AuthProvider.fromRead(Ref ref) {
    final authRepository = ref.read(authRepositoryProvider);
    return AuthProvider(ref: ref, authRepository: authRepository);
  }

  final Ref ref;
  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(user: StateAsync.loading());
    final res = await authRepository.login(email, password);
    res.fold(
      (l) {
        state = state.copyWith(user: StateAsync.error(l));
        ref.read(routerProvider).router.push(ErrorScreen.route, extra: {'error': l.message});
      },
      (r) {
        state = state.copyWith(user: StateAsync.success(r.user));
        ref.read(routerProvider).router.pop();
      },
    );
  }

  Future<void> register(User user) async {
    state = state.copyWith(user: StateAsync.loading());
    final res = await authRepository.register(user);
    if (res != null) return;
  }

  Future<void> getUserByToken() async {
    state = state.copyWith(user: StateAsync.loading());
    final res = await authRepository.getUserByToken();
    res.fold(
      (l) => state = state.copyWith(user: StateAsync.error(l)),
      (r) {
        if (r == null) {
          state = state.copyWith(user: StateAsync.initial());
          return;
        }
        state = state.copyWith(user: StateAsync.success(r));
      },
    );
  }
}
