import 'package:drug_scanner/app_screen/search.dart';
import 'package:flutter/material.dart';
import 'app_screen/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'DrugScanner';
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: SearchScreen(),
    );
  }
}
