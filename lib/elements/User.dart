import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

Profile? globalAuthedUser;

class Profile {
  final String image, name, email, weight, birthdate;
  Profile({
    required this.image,
    required this.name,
    required this.email,
    required this.weight,
    required this.birthdate,
  });
}

Future<Profile?> assignGlobalAuthedUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  String idToken = await user!.getIdToken();

  print(idToken);
  // print(user.uid);
  Uri url = Uri.parse(
      'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/${user.uid}.json');

  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    // print(response.statusCode);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);
    if (data.isNotEmpty) {
      globalAuthedUser = Profile(
        image: data["img"],
        name: data["name"],
        email: data["email"],
        weight: data["weight"],
        birthdate: data["birthdate"],
      );
      return globalAuthedUser;
    } else {
      return null;
    }
    // Extract the profile data from the response
    // ...
  } else {
    return null;
    // Handle errors
    // ...
  }
}