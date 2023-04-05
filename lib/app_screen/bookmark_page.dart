import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drug_detail.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key, this.search}) : super(key: key);
  final String? search;

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final searchField = TextEditingController();
  Widget appBarTitle = const Text('กำลังโหลด...');

  List<DrugDataModel> drugData = [];

  @override
  void initState() {
    super.initState();
    getDrugData(widget.search, null, null, null);
    searchField.text = widget.search ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xffFFC30F),
            foregroundColor: Colors.black,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text('รายการบันทึก'),
            bottom: AppBar(
              backgroundColor: const Color(0xffFFC30F),
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    controller: searchField,
                    decoration: InputDecoration(
                        hintText: 'ค้นหาด้วยชื่อยา...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xffFFC30F),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: const Color(0xffFFC30F),
                          onPressed: () {},
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'พบผลการค้นหาทั้งหมด: ${drugData.length} รายการ',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )),
          SliverList(
            //เริ่มลิสต์ยา
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DrugDetail(
                            drugDataModel: drugData[index],
                            isBookmarked: true,
                            isFromBookmarkPage: true,
                          )));
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 1, 0),
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,

                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: BoxOfPill(
                                image: drugData[index].image,
                                title: drugData[index].name,
                                subtitle: drugData[index].name))
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: drugData.length),
          ),
        ],
      ),
    );
  }

  Future<void> getDrugData(
      String? search, String? type, String? color, String? shape) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    List<DrugDataModel> drugs = [];

    String baseURL =
        'https://drugscanner-ae525-default-rtdb.asia-southeast1.firebasedatabase.app/users/${user!.uid}.json';
    String baseURL2 = 'https://sv1.p0nd.dev/drugScanner/?';
    // if (search != null) {
    //   baseURL += '&search=$search';
    // } else if (type != null) {
    //   baseURL += '&type=$type';
    // } else if (color != null) {
    //   baseURL += '&color=$color';
    // } else if (shape != null) {
    //   baseURL += '&shape=$shape';
    // }

    Uri url = Uri.parse(baseURL);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> dataBookmark =
          data["bookmark"] ?? []; // Get the List<dynamic> from the map
      List<String> drugsBookmark =
          dataBookmark.map((item) => item.toString()).toList();
      Uri url2 = Uri.parse(baseURL2);
      http.Response response2 = await http.get(url2);
      if (response2.statusCode == 200) {
        // print(response.statusCode);
        Map<String, dynamic> data = jsonDecode(response2.body);
        data.forEach((key, value) {
          // print(key);
          if (drugsBookmark.contains(key)) {
            drugs.add(DrugDataModel(
                id: key,
                name: value["name"],
                image: value.containsKey("image") ? value["image"] : null,
                type: value["type"],
                color: value["appearance"]["color"],
                shape: value["appearance"]["shape"],
                alias: value["alias"],
                usedFor: value["for"],
                usage: value["usage"]));
          }
        });
      }
      // print(drugsBookmark);
    }

    setState(() {
      drugData = drugs;

      // loadingTitle = const SizedBox(width: 1);
      // appBarTitle = Text(
      //   'พบผลการค้นหาทั้งหมด ${drugData.length} รายการ',
      //   style: const TextStyle(fontSize: 18),
      // );
    });
  }
}

class BoxOfPill extends StatelessWidget {
  final String title, subtitle;
  late String? image;
  BoxOfPill(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    image = image ??
        "https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png";
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8), //ระยะกล่อง
      child: Material(
        color: Colors.transparent,
        elevation: 3, //เงา
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), //ขอบโค้ง
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            // ของในกล่อง
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Image(
                        image: NetworkImage(image!),
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
