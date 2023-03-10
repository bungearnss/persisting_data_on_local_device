import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'src/screens/about_screen.dart';
import 'src/screens/order_screen.dart';
import './src/screens/home_screen.dart';
import './src/components/shopping_notes.dart';
import './src/screens/preference_screen.dart';
import './src/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insta Store',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SettingScreen(),
    );
  }
}
