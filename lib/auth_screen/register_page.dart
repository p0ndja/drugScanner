import 'package:flutter/material.dart';
import '../elements/avatar_upload.dart';
import '../app_screen/container.dart';
import '../elements/custom_form.dart';

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
                    const AvatarUpload(),
                    const CustomForm(name: 'อีเมล', width: 250),
                    const CustomForm(name: 'รหัสผ่าน', width: 250),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomForm(name: 'วันเกิด', width: 125),
                        Container(
                          margin: const EdgeInsets.only(top: 20, right: 10.0),
                          height: 35,
                          width: 10,
                        ),
                        const CustomForm(name: 'นํ้าหนัก', width: 80),
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
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff142F2F)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainContainerWidget()),
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
