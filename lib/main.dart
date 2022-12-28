import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_your_table_waiter/app.dart';
import 'package:on_your_table_waiter/firebase_options.dart';
import 'package:oyt_front_core/push_notifications/push_notif_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = true;
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationProvider.setupInteractedMessage();
  runApp(const ProviderScope(child: MyApp()));
}
