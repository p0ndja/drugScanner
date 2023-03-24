import 'package:drug_scanner/elements/Avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import '../auth_screen/login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 35,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: const Color(0xff008080),
        ),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: 1, // between 0 and 1
              heightFactor: 0.27,
              child: Container(
                color: const Color(0xff008080),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _avatarUpload(context),
                    inputBox('อีเมล', 250),
                    inputBox('รหัสผ่าน', 250),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: inputBox('ชื่อ', 170),
                        ),
                        inputBox('อายุ', 55),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 35,
                          width: 15,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('ปี'),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        inputBox('น้ำหนัก', 95),
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 10.0),
                          height: 35,
                          width: 25,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('กก.'),
                          ),
                        ),
                        inputBox('ส่วนสูง', 95),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          height: 35,
                          width: 25,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('ซม.'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _saveButton(context),
                    _logoutButton(context)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget _avatarUpload(context) {
  return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          scafMsg(context, 'อัปโหลดรูปภาพ');
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
      ));
}

Widget _saveButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () {
          scafMsg(context, 'บันทึกข้อมูล');
          Navigator.pop(context);
        },
        icon: const Icon(Icons.save_rounded),
        label: const Text('บันทึก')),
  );
}

Widget _logoutButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xffD70000)),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();

          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User is currently signed out!');
            } else {
              print('User is signed in!');
            }
          });

          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        icon: const Icon(Icons.logout),
        label: const Text('ออกจากระบบ')),
  );
}

scafMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 1),
  ));
}
