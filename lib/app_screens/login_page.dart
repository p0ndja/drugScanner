import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconApp,
              _inputBox('อีเมล'),
              _inputBox('รหัสผ่าน'),
              _forgetPasswordButton(),
              _button(
                'เข้าสู่ระบบ',
                Icons.login,
              ),
              const Text('หรือสมัครสมาชิก'),
              const SizedBox(
                height: 5,
              ),
              _button(
                'สมัครสมาชิก',
                Icons.app_registration,
              )
            ],
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

Widget _inputBox(String name) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            textAlign: TextAlign.start,
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

Widget _button(String label, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label)),
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
