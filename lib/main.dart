import 'package:drug_scanner/app_screen/bookmark_page.dart';
import 'package:drug_scanner/elements/User.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:drug_scanner/app_screen/container.dart';
import 'package:flutter/material.dart';
import 'app_screen/search_homepage.dart';
import 'auth_screen/login_page.dart';
import 'auth_screen/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       // ChangeNotifierProvider(create: (_) => ProfileProvider()),
  //     ],
  //     child: const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'DrugScanner';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Inter',
          fontFamilyFallback: ["Kanit"],
        ),
        title: _title,
        initialRoute: '/login',
        routes: {
          '/': (context) => const MainContainerWidget(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/bookmark': (context) => const BookmarkPage(),
        });
  }
}
