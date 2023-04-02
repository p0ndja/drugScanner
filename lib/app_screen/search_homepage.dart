import 'package:drug_scanner/app_screen/search_result_page.dart';
import 'package:drug_scanner/auth_screen/user_page.dart';
import 'package:drug_scanner/elements/Avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../elements/Date.dart';
import '../elements/User.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchField = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
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
                  Text(globalAuthedUser?.name ?? 'User',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  Text(
                      '${globalAuthedUser?.birthdate != null ? 'อายุ ${ageYear(ageParse(globalAuthedUser?.birthdate ?? "1999-01-01"))} ปี ' : ''}น้ำหนัก ${globalAuthedUser?.weight} กิโลกรัม'),
                  Container(
                    color: Colors.black12,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: TextField(
                        controller: _searchField,
                        decoration: InputDecoration(
                            prefix: const Padding(
                                padding: EdgeInsets.only(left: 15)),
                            hintText: 'ค้นหาด้วยชื่อยา...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              color: const Color(0xff008080),
                              iconSize: 30,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => SearchPage(search: _searchField.text)));
                              },
                            ),
                            border: InputBorder.none),
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
                          BoxChoiceColorPill(Colors.red),
                          BoxChoiceColorPill(Colors.blue),
                          BoxChoiceColorPill(Colors.white),
                          BoxChoiceColorPill(Colors.yellow),
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
                          BoxChoiceShapePill('วงกลม', Icons.circle),
                          BoxChoiceShapePill('วงรี', Icons.egg_rounded),
                          BoxChoiceShapePill('แคปซูล', Icons.toggle_off),
                          BoxChoiceShapePill('สามเหลียม', Icons.play_arrow),
                          BoxChoiceShapePill('สี่เหลียม', Icons.square),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

Widget _avatarUpload(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserPage()));
        },
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)
              ]),
          child: UserCircleAvatar(imageUrl: globalAuthedUser?.image ?? ""),
        ),
      ));
}

class BoxChoiceColorPill extends StatelessWidget {
  final color;
  const BoxChoiceColorPill(this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: Material(
        color: Color(0xffeeeeee), //สีกล่อง
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          //กรอบ
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            // color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            //ของในกล่อง
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color, //Color(0xFFF1F4F8), //สีวงกลม
                  shape: BoxShape.circle,
                ),
                //   child: Icon(
                //     icon,
                //     color: Color(0xFF95A1AC),
                //     size: 32,
                //   ),
                // ),
                // Padding(
                //   padding:
                //   EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                //   child: Text(
                //     name,style: TextStyle(color: color),
                //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxChoiceShapePill extends StatelessWidget {
  final name, icon;
  const BoxChoiceShapePill(this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: Material(
        color: Colors.transparent, //สีกล่อง
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          //กรอบ
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            //ของในกล่อง
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F4F8), //สีวงกลม
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF95A1AC),
                  size: 32,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
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
