import 'package:drug_scanner/app_screen/container.dart';
import 'package:flutter/material.dart';
import 'auth_screen/login_page.dart';
import 'auth_screen/register_page.dart';

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
        initialRoute: '/login',
        routes: {
          '/': (context) => const MainContainerWidget(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        }
    );
  }
}
