import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../app_screen/container.dart';
import '../elements/User.dart';
import 'register_page.dart';
import '../elements/custom_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmail(String email, String password) async {
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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
        Navigator.of(context).pop();
      });
      await assignGlobalAuthedUser();
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String errorMessage = e.code;
      if (e.code == 'user-not-found') {
        errorMessage = 'ไม่พบบัญชีผู้ใช้ดังกล่าวในระบบ';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'รหัสผ่านไม่ถูกต้อง';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'อีเมลไม่ถูกต้อง';
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
    }
  }

  void _submitForm() {
    _signInWithEmail(_emailController.text, _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    iconApp,
                    CustomForm(
                      name: 'อีเมล',
                      width: 250,
                      textEditingController: _emailController,
                    ),
                    CustomForm(
                        name: 'รหัสผ่าน',
                        width: 250,
                        textEditingController: _passwordController),
                    _forgetPasswordButton(),
                    _loginButton(context, _submitForm),
                    const Text('หรือ'),
                    const SizedBox(
                      height: 5,
                    ),
                    _registerPageButton(context)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

Widget iconApp = Container(
  margin: const EdgeInsets.only(bottom: 30),
  padding: const EdgeInsets.all(1), // Border width
  decoration: BoxDecoration(
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      borderRadius: BorderRadius.circular(20)),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: SizedBox.fromSize(
      size: const Size.fromRadius(105), // Image radius
      child: Image.asset(
        'images/iconApp.png',
        fit: BoxFit.cover,
      ),
    ),
  ),
);

Widget inputBox(String name, double width) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: width,
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            textAlign: TextAlign.start,
            style: const TextStyle(fontFamily: 'Kanit'),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 35,
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
          ),
        )
      ],
    ),
  );
}

Widget _registerPageButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff142F2F)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        icon: const Icon(Icons.app_registration),
        label: const Text('สมัครสมาชิก')),
  );
}

Widget _loginButton(BuildContext context, void Function() submitForm) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () {
          submitForm();
        },
        icon: const Icon(Icons.login),
        label: const Text('เข้าสู่ระบบ')),
  );
}

Widget _forgetPasswordButton() {
  return Container(
    margin: const EdgeInsets.only(left: 183),
    width: 85,
    child: TextButton(
      style: TextButton.styleFrom(foregroundColor: Colors.red),
      onPressed: (() {}),
      child: const Text(
        'ลืมรหัสผ่าน',
      ),
    ),
  );
}
