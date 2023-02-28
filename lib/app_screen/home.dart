import 'package:drug_scanner/app_screen/user_page.dart';
import 'package:flutter/material.dart';

import '../elements/Avatar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _avatarUpload(context),
    );
  }
}

Widget _avatarUpload(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserPage())
          );
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)
              ]),
          child: UserCircleAvatar(imageUrl: URLPath),
        ),
      )
  );
}
