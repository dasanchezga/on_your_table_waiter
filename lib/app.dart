import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_your_table_waiter/core/router/router.dart';
import 'package:oyt_front_core/theme/theme.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final routerProv = ref.read(routerProvider);
    return MaterialApp.router(
      title: 'Restaurants',
      routeInformationProvider: routerProv.goRouter.routeInformationProvider,
      routeInformationParser: routerProv.goRouter.routeInformationParser,
      routerDelegate: routerProv.goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.myTheme(),
    );
  }
}
