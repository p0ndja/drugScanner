import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'container.dart';

List<String> drugsBookmark = [];

class DrugDataModel {
  final String? image;
  final String name, usedFor, color, shape, id;
  final List alias, type, usage;
  DrugDataModel({
    required this.id,
    required this.image,
    required this.name,
    required this.usedFor,
    required this.color,
    required this.shape,
    required this.alias,
    required this.type,
    required this.usage,
  });
}

class DrugDetail extends StatefulWidget {
  final DrugDataModel drugDataModel;
  bool? isFromBookmarkPage = false;
  bool? isBookmarked = false;
  DrugDetail(
      {Key? key,
      required this.drugDataModel,
      this.isBookmarked,
      this.isFromBookmarkPage})
      : super(key: key);

  @override
  _DrugDetailState createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getListFromDatabase();
  }

  void toggleBookmark() {
    setState(() {
      getListFromDatabase();

      widget.isBookmarked = !(widget.isBookmarked ?? false);

      if (widget.isBookmarked == true) {
        if (!drugsBookmark.contains(widget.drugDataModel.id)) {
          drugsBookmark.add(widget.drugDataModel.id);
        }
      } else {
        drugsBookmark = drugsBookmark
            .where((drug) => drug != widget.drugDataModel.id)
            .toList();
      }
      addListToDatabase(drugsBookmark);
    });
  }

  Future<void> getListFromDatabase() async {
    User? user = auth.currentUser;
    final databaseUrl = Uri.parse(
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/${user!.uid}.json');
    final responseGetId = await http.get(databaseUrl);

    if (responseGetId.statusCode == 200) {
      final data = json.decode(responseGetId.body);
      drugsBookmark = List.castFrom<dynamic, String>(data['bookmark'] ?? []);
      print('$drugsBookmark 555555');
      // final list = data.values.cast<String>().toList();
    } else {
      throw Exception(
          'Failed to get list from database: ${responseGetId.body}');
    }
  }

  Future<void> addListToDatabase(List<String> list) async {
    User? user = auth.currentUser;
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.currentUser;

    final databaseUrl = Uri.parse(
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/${user!.uid}.json');

    final response = await http.patch(
      databaseUrl,
      body: json.encode({"bookmark": list}),
    );

    if (response.statusCode == 200) {
      print('List added to database');
    } else {
      print('Failed to add list to database: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (widget.isFromBookmarkPage ?? false) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                selectedIndex = 2;
                Navigator.of(context).popAndPushNamed("/");
              } else {
                Navigator.of(context).pop(context);
              }
            },
          ),
          actions: [
            IconButton(
              color: Colors.white,
              icon: widget.isBookmarked ?? false
                  ? const Icon(Icons.bookmark_add, color: Colors.red)
                  : const Icon(Icons.bookmark_add, color: Colors.black),
              onPressed: () {
                toggleBookmark();
              },
            ),
          ],
          elevation: 0,
          backgroundColor: widget.drugDataModel.image != null
              ? Colors.transparent
              : const Color(0xff008080),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: SafeArea(
                      child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: widget.drugDataModel.image != null ? 200 : 0,
                        ),
                        Expanded(
                            child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.drugDataModel.name,
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.drugDataModel.alias.join(", "),
                                        style: TextStyle(color: Colors.grey)),
                                    const SizedBox(height: 20),
                                    Text("ประเภทยา",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.drugDataModel.type.join(", ")),
                                    const SizedBox(height: 20),
                                    Text("สรรพคุณ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.drugDataModel.usedFor),
                                    const SizedBox(height: 20),
                                    Text("รูปลักษณ์",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "สี: ${widget.drugDataModel.color == "variant" ? "หลากสี" : widget.drugDataModel.color}\nรูปร่าง: ${widget.drugDataModel.shape == "variant" ? "หลากรูปร่าง" : widget.drugDataModel.shape}"),
                                    const SizedBox(height: 20),
                                    Text("วิธีการใช้ยา",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.drugDataModel.usage.join("\n")),
                                  ],
                                ))),
                      ],
                    ),
                  )),
                ),
              );
            }),
            Visibility(
                visible: widget.drugDataModel.image != null,
                child: Column(
                  children: [
                    Container(
                      height: 320,
                      alignment: Alignment.center, // This is needed
                      child: Image.network(
                        widget.drugDataModel.image ??
                            "https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png",
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
