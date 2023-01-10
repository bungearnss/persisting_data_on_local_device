import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import './src/about_screen.dart';
import './src/order_screen.dart';

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
        primarySwatch: Colors.purple,
      ),
      home: const OrderScreen(),
    );
  }
}
