import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    _avatarUpload(),
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
                    _registerButton(context),
                    const Text('หรือเข้าสู่ระบบ'),
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

Widget _registerButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5.0),
    width: 250,
    child: ElevatedButton.icon(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff008080)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
          );
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

Widget _avatarUpload() {
  return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          debugPrint('ddd');
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)
              ]),
          child: CircleAvatar(
            backgroundImage: null,
            backgroundColor: Colors.grey[300],
            radius: 90,
            child: const Icon(
              Icons.upload,
              color: Colors.black38,
              size: 40,
            ),
          ),
        ),
      ));
}
