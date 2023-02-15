import 'package:drug_scanner/app_screen/user_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _avatarUpload(context),
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
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://scontent.fkkc4-1.fna.fbcdn.net/v/t1.6435-9/58734128_1581933278607096_4121677932680708096_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGSYlXNvmEm9Ko53j0U4fU1B7P1uXcF0h0Hs_W5dwXSHT-HVE_9F7PF8KPugETuU7zQpz-hbD81naMloWMZ8F1l&_nc_ohc=mV-Qvu6FOCYAX_ngIf9&_nc_ht=scontent.fkkc4-1.fna&oh=00_AfAYqvT-oJWI09rpUePQaHkKqI_iRVeeLxFV65XOOowCjQ&oe=640EC60B'),
            radius: 90,
          ),
        ),
      ));
}
