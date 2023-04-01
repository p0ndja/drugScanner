import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

import 'package:drug_scanner/elements/Avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import '../elements/User.dart';
import '../elements/avatar_upload.dart';
import 'login_page.dart';
import '../elements/custom_form.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _birthdateController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void sendPatch(Map jsonData, String uid) {
    final url = Uri.parse(
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/$uid.json');
    http.patch(url, body: json.encode(jsonData));
  }

  Future<void> changeInfoUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      String idToken = await user!.getIdToken();
      String imgPath = await uploadImg();
      sendPatch({
        'email': user.email.toString(),
        'img': imgPath,
        'name': _nameController.text,
        'birthdate': _birthdateController.text.trim(),
        'weight': _weightController.text.trim()
      }, user.uid);

      await assignGlobalAuthedUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String idToken = await user!.getIdToken();

    print(idToken);
    // print(user.uid);
    Uri url = Uri.parse(
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/${user.uid}.json');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        _emailController.text = data["email"];
        _passwordController.text = data["email"];
        _nameController.text = data["name"];
        _weightController.text = data["weight"];
        _birthdateController.text = data["birthdate"];
      });

      // Extract the profile data from the response
      // ...
    } else {
      print('error response.statusCode != 200');
      // Handle errors
      // ...
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    getUser();
    super.initState();
  }

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
                    const AvatarUpload(),
                    // _avatarUpload(context),
                    // inputBox('อีเมล', 250),
                    // inputBox('รหัสผ่าน', 250),
                    CustomForm(
                      name: 'อีเมล',
                      width: 250,
                      textEditingController: _emailController,
                    ),
                    // CustomForm(
                    //   name: 'รหัสผ่าน',
                    //   width: 250,
                    //   textEditingController: _passwordController,
                    // ),
                    CustomForm(
                      name: 'ชื่อ',
                      width: 250,
                      textEditingController: _nameController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomForm(
                          name: 'วันเกิด',
                          width: 125,
                          textEditingController: _birthdateController,
                        ),
                        // const CustomForm(name: 'วันเกิด', width: 125),
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 10.0),
                          height: 35,
                          width: 10,
                        ),
                        CustomForm(
                          name: 'นํ้าหนัก',
                          width: 80,
                          textEditingController: _weightController,
                        ),
                        // const CustomForm(name: 'นํ้าหนัก', width: 80),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          height: 35,
                          width: 25,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text('กก.'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    _saveButton(context, changeInfoUser),
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

Widget _saveButton(BuildContext context, Function() changeInfoUser) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () async {
          showDialog(
            // The user CANNOT close this dialog  by pressing outsite it
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return Dialog(
                  // The background color
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        // The loading indicator
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        // Some text
                        Text('กำลังโหลด...')
                      ],
                    ),
                  ),
                );
              }
          );
          await changeInfoUser();
          scafMsg(context, 'บันทึกข้อมูล');
          // getUser();
          Navigator.of(context).popUntil((route) => route.isFirst);
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
