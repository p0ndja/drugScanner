import 'package:drug_scanner/app_screen/bookmark_page.dart';
import 'package:drug_scanner/app_screen/home_page.dart';
import 'package:drug_scanner/app_screen/search_result_page.dart';
import 'package:drug_scanner/app_screen/user_page.dart';
import 'package:flutter/material.dart';
import 'package:drug_scanner/app_screen/search.dart';
import 'package:drug_scanner/app_screen/home.dart';

int selectedIndex = 0;

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomePage(),
    BookmarkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DrugScanner'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: bottomNavigator(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.large(
          shape: const CircleBorder(),
          onPressed: () => {_onItemTapped(1)},
          child: const Icon(Icons.camera_alt),
        ));
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
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmark',

        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.teal,
      onTap: _onItemTapped,
    );
  }
}
