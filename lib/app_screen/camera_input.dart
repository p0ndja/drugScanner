import 'package:flutter/material.dart';
import 'dart:developer';

class CameraInput extends StatefulWidget {
  const CameraInput({Key? key}) : super(key: key);

  @override
  State<CameraInput> createState() => _CameraInputState();
}

class _CameraInputState extends State<CameraInput> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Camera Search'),
        ),
        body: Container(height: double.infinity, width: double.infinity, color: Colors.black, child: Center(child: CircularProgressIndicator(color: Colors.yellowAccent))),
      ),
    );
  }
}