import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomForm extends StatefulWidget {
  const CustomForm(
      {Key? key,
      required this.name,
      required this.width,
      required this.textEditingController})
      : super(key: key);

  final String name;
  final double width;
  final TextEditingController textEditingController;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  // final myController = widget.textEditingController;
  late String email;
  late String password;

  bool _obscureText = true;
  String _hintText = '';
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void submitForm() async {
    if (widget.name == 'อีเมล') {
      email = widget.textEditingController.text.trim();
    }
    if (widget.name == 'รหัสผ่าน') {
      password = widget.textEditingController.text.trim();
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to next screen upon successful registration
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Handle any errors that occur during registration
      print(e);
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  void _changeHintText() {
    setState(() {
      if (widget.name == 'อีเมล') {
        _hintText = 'example@xxx.com';
      } else if (widget.name == 'วันเกิด') {
        _hintText = 'กรอกวันเกิด';
      } else if (widget.name == 'รหัสผ่าน') {
        _hintText = 'กรอกรหัสผ่าน';
      } else if (widget.name == 'นํ้าหนัก') {
        _hintText = 'กรอกนํ้าหนัก';
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _changeHintText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      width: widget.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontFamily: 'Kanit'),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          SizedBox(
            height: 35,
            child: TextField(
              onTap: () async {
                if (widget.name == 'วันเกิด') {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    setState(() {
                      widget.textEditingController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  }
                }
              },
              obscureText: (widget.name == 'รหัสผ่าน') ? _obscureText : false,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  hintText: _hintText,
                  suffixIcon: (widget.name == 'รหัสผ่าน')
                      ? GestureDetector(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        )
                      : null,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0)),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
            ),
          )
        ],
      ),
    );
  }
}
