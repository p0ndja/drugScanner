import 'package:flutter/material.dart';

String URLPath = "https://sunsetanytime.com/wp-content/uploads/2022/09/White-Background-Placeholder-Person.jpg";

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
