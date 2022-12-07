import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:oyt_front_core/constants/lotti_assets.dart';
import 'package:on_your_table_waiter/ui/auth/login_screen.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:on_your_table_waiter/ui/widgets/buttons/custom_elevated_button.dart';

class NotAuthenticatedBottomSheet extends StatelessWidget {
  const NotAuthenticatedBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) => const NotAuthenticatedBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '¡Alto ahi marinero!',
                style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: Navigator.of(context).pop, icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(height: 10),
          Lottie.asset(
            LottieAssets.sailor,
            height: 170,
            width: double.infinity,
          ),
          const SizedBox(height: 10),
          Text(
            'Para continuar debes estar autenticado',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              GoRouter.of(context).push(LoginScreen.route);
            },
            child: const Text('Autenticarme'),
          ),
          SizedBox(height: 10 + MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
