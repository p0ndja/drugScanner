import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

XFile? image;
Future uploadImg() async {
  if (image == null) return null;

  final storageRef = FirebaseStorage.instance.ref();
  final picRef = storageRef.child(image!.name);
  final picImgRef = storageRef.child(image!.path);
  assert(picRef.name == picImgRef.name);
  assert(picRef.fullPath != picImgRef.fullPath);
  try {
    await picRef.putFile(File(picImgRef.fullPath));
    return await picRef.getDownloadURL();
  } on FirebaseException catch (e) {
    print('error: $e');
  }
}

class AvatarUpload extends StatefulWidget {
  const AvatarUpload({Key? key}) : super(key: key);

  @override
  _AvatarUploadState createState() => _AvatarUploadState();
}

class _AvatarUploadState extends State<AvatarUpload> {

  final ImagePicker picker = ImagePicker();

  // void sendPost() {
  //   final url = Uri.parse(
  //       'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/user.json');
  //   http.post(url, body: json.encode({'time': 'now'}));
  // }

  //we can upload image from camera or from gallery based on parameter
  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: GestureDetector(
          onTap: () {
            // sendPost();

            myAlert();
            debugPrint('ddd');
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.black, spreadRadius: 1)
                ]),
            child: CircleAvatar(
                backgroundImage: null,
                backgroundColor: Colors.grey[300],
                radius: 90,
                child: ClipOval(
                  child: image != null
                      ? Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        )
                      : const Icon(
                          Icons.upload,
                          color: Colors.black38,
                          size: 40,
                        ),
                )),
          ),
        ));
  }
}
