import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_your_table_waiter/app.dart';
import 'package:on_your_table_waiter/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  await Hive.initFlutter();
  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp(
      options: Firebase.apps.isNotEmpty ? DefaultFirebaseOptions.currentPlatform : null,
    );
  }
  runApp(const ProviderScope(child: MyApp()));
}
