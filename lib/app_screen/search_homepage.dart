import 'package:drug_scanner/app_screen/search_result_page.dart';
import 'package:drug_scanner/auth_screen/user_page.dart';
import 'package:drug_scanner/elements/Avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../elements/Date.dart';
import '../elements/User.dart';

List<ToggleButtonHelper> colorBtn = [
  ToggleButtonHelper(text: "All", color: Colors.black, icon: null, isSelected: true),
  ToggleButtonHelper(text: "White", color: Colors.black54, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Red", color: Colors.red, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Green", color: Colors.green, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Blue", color: Colors.blue, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Pink", color: Colors.pinkAccent, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Yellow", color: Colors.orange, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Orange", color: Colors.deepOrange, icon: null, isSelected: false),
  ToggleButtonHelper(text: "Black", color: Colors.black, icon: null, isSelected: false),
];
List<ToggleButtonHelper> shapeBtn = [
  ToggleButtonHelper(text: "All", color: Colors.black54, icon: Icons.interests, isSelected: true),
  ToggleButtonHelper(text: "Circle", color: Colors.black54, icon: Icons.circle, isSelected: false),
  ToggleButtonHelper(text: "Oval", color: Colors.black54, icon: Icons.egg_rounded, isSelected: false),
  ToggleButtonHelper(text: "Capsule", color: Colors.black54, icon: Icons.toggle_off, isSelected: false),
  ToggleButtonHelper(text: "Triangle", color: Colors.black54, icon: Icons.play_arrow, isSelected: false),
  ToggleButtonHelper(text: "Square", color: Colors.black54, icon: Icons.square, isSelected: false),
];

class ToggleButtonHelper {
  final String text;
  final Color color;
  final IconData? icon;
  late bool isSelected;

  ToggleButtonHelper({required this.text, required this.color, this.icon, required this.isSelected});

  Widget widget() {
    return Container(
        color: !isSelected ? Colors.white : color, width: 100, height: double.infinity,
        child: icon != null ?
          Center(child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Column(children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Color(0xFFF1F4F8), //สีวงกลม
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon!,
                color: isSelected ? Colors.white : color,
                size: 32,
              ),
            ),
            Text(text, style: TextStyle(color: isSelected ? Colors.white : color, fontWeight: FontWeight.bold, fontSize: 16))
          ],)))
            :
          Center(child: Text(text, style: TextStyle(color: isSelected ? Colors.white : color, fontWeight: FontWeight.bold, fontSize: 16)))
    );
  }

  bool setToggle(bool sts) {
    isSelected = sts;
    return isSelected;
  }

  String txt() {
    return text;
  }
}
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
              physics: const ClampingScrollPhysics(),
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
                                Navigator.push(context, MaterialPageRoute(builder: (builder) => SearchPage(search: _searchField.text, color: colorBtn[colorBtn.indexWhere((element) => element.isSelected)].text, shape: shapeBtn[shapeBtn.indexWhere((element) => element.isSelected)].text)));
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
                      child: ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < colorBtn.length; i++) {
                              colorBtn[i].setToggle(i == index);
                            }
                          });
                        },
                        selectedBorderColor: Colors.black12,
                        selectedColor: Colors.black38,
                        fillColor:  Colors.black38,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: colorBtn.map((e) => e.isSelected).toList(),
                        children: colorBtn.map((e) => e.widget()).toList(),
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
                      child: ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < shapeBtn.length; i++) {
                              shapeBtn[i].setToggle(i == index);
                            }
                          });
                        },
                        selectedBorderColor: Colors.black12,
                        selectedColor: Colors.black38,
                        fillColor:  Colors.black38,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: shapeBtn.map((e) => e.isSelected).toList(),
                        children: shapeBtn.map((e) => e.widget()).toList(),
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
      child: MaterialButton(
        color: Color(0xffeeeeee), //สีกล่อง
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {  },
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
      )
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
