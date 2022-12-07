import 'package:flutter/material.dart';
import 'package:oyt_front_core/validators/text_form_validator.dart';
import '../widgets/backgrounds/animated_background.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/buttons/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const route = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Key _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: GoRouter.of(context).pop,
                icon: const Icon(Icons.arrow_back),
              ),
            ],
          ),
          //const SizedBox(height: 10),
          const Text(
            'Regístrate',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomTextField(
                  label: 'Nombres',
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  label: 'Apellidos',
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Correo',
                  validator: TextFormValidator.emailValidator,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  maxLines: 1,
                  controller: TextEditingController(text: ''),
                  validator: TextFormValidator.passwordValidator,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Confirma la contraseña',
                  obscureText: true,
                  maxLines: 1,
                  controller: TextEditingController(text: ''),
                  validator: TextFormValidator.passwordValidator,
                ),
                const SizedBox(height: 20),
                const CustomTextField(
                  label: 'Celular',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: (showConfirmation),
            child: const Text('Registrarse'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  showConfirmation() {
    Widget okButton = CustomElevatedButton(
      child: const Text('Aceptar'),
      onPressed: () => context.go('/login'),
    );

    AlertDialog confirmation = AlertDialog(
      title: const Text('Bienvenido'),
      content: const Text('El registro ha sido exitoso.'),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return confirmation;
      },
    );
  }
}

void handleOnRegister() {}
