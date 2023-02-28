import 'package:drug_scanner/app_screen/bookmark_page.dart';
import 'package:drug_scanner/app_screen/search_homepage.dart';
import 'package:flutter/material.dart';
import 'package:drug_scanner/app_screen/camera_input.dart';

int selectedIndex = 0;

class MainContainerWidget extends StatefulWidget {
  const MainContainerWidget({super.key});

  @override
  State<MainContainerWidget> createState() => _MainContainerWidgetState();
}

class _MainContainerWidgetState extends State<MainContainerWidget> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CameraInput(),
    BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('DrugScanner'),
        //   automaticallyImplyLeading: false,
        // ),
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: bottomNavigator()
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget bottomNavigator() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.teal,
      onTap: _onItemTapped,
    );
  }
}
