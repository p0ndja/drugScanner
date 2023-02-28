
import 'package:drug_scanner/app_screen/search_result_page.dart';
import 'package:drug_scanner/app_screen/user_page.dart';
import 'package:drug_scanner/elements/Avatar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                    _avatarUpload(context),
                    Text('Fordranger Raptor',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                    Text('อายุ 25 ปี ส่วนสูง 163 ซม. น้ำหนัก 55 กก.'),
                    Container(
                      color: Colors.black12,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              prefix: const Padding(padding: EdgeInsets.only(left: 15)),
                              hintText: 'ค้นหาด้วยชื่อยา...',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                color: const Color(0xff008080),
                                iconSize: 30,
                                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (builder) => SearchPage())); },
                              ),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'สีของเม็ดยา',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 1, 0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BoxChoice('แดง',Icons.medical_services),
                            BoxChoice('ฟ้า',Icons.medical_services),
                            BoxChoice('ขาว',Icons.medical_services),
                            BoxChoice('เหลือง',Icons.medical_services),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'ลักษณะของเม็ดยา',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 1, 0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BoxChoice('วงกลม',Icons.circle),
                            BoxChoice('วงรี',Icons.egg_rounded),
                            BoxChoice('แคปซูล',Icons.toggle_off),
                            BoxChoice('สามเหลียม',Icons.play_arrow),
                            BoxChoice('สี่เหลียม',Icons.square),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          ),
        ]
      )
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
      ));
}



class BoxChoice extends StatelessWidget {
  final name,icon;
  const BoxChoice(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF95A1AC),
                  size: 32,
                ),
              ),
              Padding(
                padding:
                EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}