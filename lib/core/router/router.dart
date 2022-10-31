import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:on_your_table_waiter/features/bill/bill_screen.dart';
import 'package:on_your_table_waiter/features/bill/individual_pay_screen.dart';
import 'package:on_your_table_waiter/features/product/models/product_model.dart';
import 'package:on_your_table_waiter/ui/Product/product_detail.dart';
import 'package:on_your_table_waiter/ui/auth/login_screen.dart';
import 'package:on_your_table_waiter/ui/error/error_screen.dart';
import 'package:on_your_table_waiter/ui/menu/index_menu_screen.dart';
import 'package:on_your_table_waiter/ui/on_boarding/on_boarding.dart';
import 'package:on_your_table_waiter/ui/auth/register_screen.dart';
import 'package:on_your_table_waiter/ui/table/table_qr_reader_screen.dart';

final routerProvider = Provider<CustomRouter>((ref) {
  return CustomRouter();
});

class CustomRouter {
  CustomRouter();

  static String atributeErrorMessage(String atribute) {
    return 'Es necesario el parametro $atribute';
  }

  final goRouter = GoRouter(
    initialLocation: OnBoarding.route,
    errorBuilder: (context, state) {
      if (state.error == null) {
        return const ErrorScreen();
      }
      return ErrorScreen(error: state.error.toString());
    },
    routes: routes,
  );

  static List<GoRoute> get routes => [
        GoRoute(path: OnBoarding.route, builder: (context, state) => const OnBoarding()),
        GoRoute(
          path: BillScreen.route,
          builder: (context, state) {
            final transactionId = state.queryParams['transactionId'];
            return transactionId == null
                ? ErrorScreen(error: atributeErrorMessage('transactionId'))
                : BillScreen(transactionId: transactionId);
          },
        ),
        GoRoute(
          path: TableQrReaderScreen.route,
          builder: (context, state) => const TableQrReaderScreen(),
        ),
        GoRoute(
          path: IndividualPayScreen.route,
          builder: (context, state) => const IndividualPayScreen(),
        ),
        GoRoute(
          path: IndexHomeScreen.route,
          builder: (context, state) => const IndexHomeScreen(),
        ),
        GoRoute(path: RegisterScreen.route, builder: (context, state) => const RegisterScreen()),
        GoRoute(
          path: ErrorScreen.route,
          builder: (context, state) {
            final error = (state.extra as Map<String, dynamic>)['error'];
            if (error == null) {
              return const ErrorScreen();
            }
            return ErrorScreen(error: error);
          },
        ),
        GoRoute(
          path: LoginScreen.route,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: ProductDetail.route,
          builder: (context, state) {
            final productId = state.queryParams['productId'];
            final prodDetail = state.extra as ProductDetailModel?;
            if (productId == null) {
              return ErrorScreen(error: atributeErrorMessage('productId'));
            } else {
              return ProductDetail(productId: productId, order: prodDetail);
            }
          },
        ),
      ];

  BuildContext get context => goRouter.navigator!.context;

  GoRouter get router => goRouter;
}
