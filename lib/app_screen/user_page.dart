import 'package:flutter/material.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'login_page.dart';

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
            onPressed: () { Navigator.pop(context);},
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
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://scontent.fkkc4-1.fna.fbcdn.net/v/t1.6435-9/58734128_1581933278607096_4121677932680708096_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGSYlXNvmEm9Ko53j0U4fU1B7P1uXcF0h0Hs_W5dwXSHT-HVE_9F7PF8KPugETuU7zQpz-hbD81naMloWMZ8F1l&_nc_ohc=mV-Qvu6FOCYAX_ngIf9&_nc_ht=scontent.fkkc4-1.fna&oh=00_AfAYqvT-oJWI09rpUePQaHkKqI_iRVeeLxFV65XOOowCjQ&oe=640EC60B'),
            radius: 90,
          ),
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
        onPressed: () {},
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
        onPressed: () {},
        icon: const Icon(Icons.logout),
        label: const Text('ออกจากระบบ')),
  );
}
