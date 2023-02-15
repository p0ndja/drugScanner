import 'package:drug_scanner/app_screen/main_page.dart';
import 'package:drug_scanner/app_screen/search_page.dart';
import 'package:flutter/material.dart';
import 'app_screen/login_page.dart';
import 'app_screen/user_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'DrugScanner';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Kanit'),
        title: _title,
        home: const LoginPage());
  }
}
