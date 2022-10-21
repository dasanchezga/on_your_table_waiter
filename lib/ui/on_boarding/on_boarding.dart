import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/core/constants/lotti_assets.dart';
import 'package:on_your_table_waiter/features/table/provider/table_provider.dart';
import 'package:on_your_table_waiter/ui/table/table_qr_reader_screen.dart';
import 'package:on_your_table_waiter/ui/widgets/bottom_sheet/table_code_sheet.dart';
import 'package:on_your_table_waiter/ui/widgets/divider.dart';
import 'package:on_your_table_waiter/ui/widgets/buttons/custom_elevated_button.dart';

class OnBoarding extends ConsumerWidget {
  const OnBoarding({Key? key}) : super(key: key);
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //Lottie.asset(
              //LottieAssets.food,
              //width: size.width,
              //height: size.height * 0.44,
            //),
            const CustomDivider(),
            AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText(
                  'On Your Table',
                  speed: const Duration(milliseconds: 100),
                  textStyle: Theme.of(context).textTheme.headline4?.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Escanea o ingresa el codigo QR de tu mesa para comenzar tu experiencia.',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () => handleOnScan(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.qr_code_2_outlined),
                  SizedBox(width: 8),
                  Text('Escanear codigo QR'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => handleOnWriteCode(context, ref),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.text_snippet_outlined),
                  SizedBox(width: 8),
                  Text('Ingresar codigo manual'),
                ],
              ),
            ),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }

  void handleOnScan(BuildContext context) => GoRouter.of(context).push(TableQrReaderScreen.route);

  void handleOnWriteCode(BuildContext context, WidgetRef ref) {
    TableCodeBottomSheet.showManualCodeSheet(
      context: context,
      onAccept: ref.read(tableProvider.notifier).onReadTableCode,
    );
  }
}
