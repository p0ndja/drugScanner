import 'package:flutter/material.dart';

String URLPath = "https://media.discordapp.net/attachments/878460741852749844/1080214463925457027/FEB4C267-B549-4AB6-BACC-BE0A5749FE85.jpg";

class UserCircleAvatar extends StatelessWidget {
  final String imageUrl;
  const UserCircleAvatar({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 90,
    );
  }
}
