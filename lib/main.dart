import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_your_table_waiter/app.dart';

void main() async {
  EquatableConfig.stringify = true;
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}
