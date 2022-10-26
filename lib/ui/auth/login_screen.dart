import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:on_your_table_waiter/core/constants/lotti_assets.dart';
import 'package:on_your_table_waiter/core/validators/text_form_validator.dart';
import 'package:on_your_table_waiter/features/auth/provider/auth_provider.dart';
import 'package:on_your_table_waiter/ui/auth/register_screen.dart';
import 'package:on_your_table_waiter/ui/widgets/backgrounds/animated_background.dart';
import 'package:on_your_table_waiter/ui/widgets/custom_text_field.dart';
import '../widgets/buttons/custom_elevated_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return AnimatedBackground(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                onPressed: GoRouter.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          const Text(
            '¡Bienvenido!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Te extrañamos',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 180,
            width: 180,
            child: Lottie.asset(
              LottieAssets.login,
              height: 180.0,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'Correo',
                  controller: _emailController,
                  validator: TextFormValidator.emailValidator,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  controller: _passwordController,
                  validator: TextFormValidator.passwordValidator,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          authState.user.on(
            onData: (u) => CustomElevatedButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
            onError: (f) => CustomElevatedButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onInitial: () => CustomElevatedButton(
              onPressed: handleOnLogin,
              child: const Text('Ingresar'),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => GoRouter.of(context).push(RegisterScreen.route),
            child: const Text('O regístrate ahora'),
          )
        ],
      ),
    );
  }

  void handleOnLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ref.read(authProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }
}
