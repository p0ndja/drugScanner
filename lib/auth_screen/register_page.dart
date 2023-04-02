import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../elements/User.dart';
import '../elements/avatar_upload.dart';

import '../elements/custom_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  final _birthdateController = TextEditingController();

  void sendPatch(Map jsonData, String uid) {
    final url = Uri.parse(
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/$uid.json');
    http.patch(url, body: json.encode(jsonData));
  }

  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String imgPath = await uploadImg();
      sendPatch({
        'name': userCredential.user!.displayName.toString(),
        'email': userCredential.user!.email.toString(),
        'img': imgPath,
        'birthdate': _birthdateController.text.trim(),
        'weight': _weightController.text.trim()
      }, userCredential.user!.uid);
      print('User account created successfully: ${userCredential.user!.uid}');
      await assignGlobalAuthedUser();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Navigator.of(context).pop();
      String errorMessage = e.code;
      if (e.code == 'weak-password') {
        errorMessage = 'รหัสผ่านของคุณอ่อนแอเกินไป';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'อีเมลนี้ได้ลงทะเบียนไว้อยู่แล้ว';
      } else {
        errorMessage = e.code;
      }
      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return AlertDialog(
              // The background color
              title: const Text('พบข้อผิดพลาด'),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(errorMessage),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    } catch (e) {
      print(e);
    }
  }

  void _submitForm() async {
    try {
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
      await registerUser(_emailController.text, _passwordController.text);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
      await assignGlobalAuthedUser();
      Navigator.pop(context);
      // Navigate to next screen upon successful registration
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      // Handle any errors that occur during registration
      print(e);
      // Display an error message to the user
      Navigator.pop(context);
      Navigator.of(context).pop();
      showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return AlertDialog(
              // The background color
              title: const Text('พบข้อผิดพลาด'),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("พบข้อผิดพลาดที่ไม่ทราบสาเหตุ โปรดลองใหม่อีกครั้งในภายหลัง"),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _birthdateController.dispose();
    _weightController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            FractionallySizedBox(
              widthFactor: 1, // between 0 and 1
              heightFactor: 0.3,
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
                    CustomForm(
                      name: 'อีเมล',
                      width: 250,
                      textEditingController: _emailController,
                    ),
                    CustomForm(
                      name: 'รหัสผ่าน',
                      width: 250,
                      textEditingController: _passwordController,
                    ),
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
                    _registerButton(context, _submitForm),
                    const Text('หรือ'),
                    const SizedBox(
                      height: 5,
                    ),
                    _loginPageButton(context)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

Widget _registerButton(BuildContext context, void Function() submitForm) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff142F2F)),
        onPressed: () {
          submitForm();
        },
        icon: const Icon(Icons.app_registration),
        label: const Text('สมัครสมาชิก')),
  );
}

Widget _loginPageButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.login),
        label: const Text('เข้าสู่ระบบ')),
  );
}
