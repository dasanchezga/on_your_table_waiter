import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData myTheme() {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.deepOrange,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
