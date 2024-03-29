import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'drug_detail.dart';

class SearchPage extends StatefulWidget {
  final String? search,type,color,shape;
  const SearchPage({Key? key, required this.search, this.type, this.color, this.shape}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchField = TextEditingController();
  Widget appBarTitle = const Text('กำลังโหลด...');
  List<DrugDataModel> drugData = [];

  @override
  void initState() {
    super.initState();
    getDrugData(widget.search, widget.type, widget.color, widget.shape);
    searchField.text = widget.search ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: const Color(0xff008080),
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: Column(children: [
            Text("ผลการค้นหา${widget.search!.isNotEmpty ? ' \"${widget.search}\"' : ''}"),
            Text("สี: ${(widget.color??"ทั้งหมด") == "All"? "ทั้งหมด": widget.color}, รูปร่าง: ${(widget.shape??"ทั้งหมด") == "All"? "ทั้งหมด": widget.shape}, ประเภท: ${(widget.shape??"ทั้งหมด") == "All"? "ทั้งหมด": widget.shape}", style: TextStyle(fontSize: 12))
            ]),
            actions: [
              Visibility(
                  visible: false,
                  child: IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  )),
            ],
            // bottom: AppBar(
            //   automaticallyImplyLeading: false,
            //   backgroundColor: const Color(0xff008080),
            //   title: Container(
            //     child: Center(
            //       child:
            //       // child: TextField(
            //       //   controller: searchField,
            //       //   decoration: InputDecoration(
            //       //       prefix:
            //       //           const Padding(padding: EdgeInsets.only(left: 15)),
            //       //       hintText: 'ค้นหาด้วยชื่อยา...',
            //       //       suffixIcon: IconButton(
            //       //         icon: const Icon(Icons.search),
            //       //         color: const Color(0xff008080),
            //       //         onPressed: () {},
            //       //       ),
            //       //       border: InputBorder.none),
            //       // ),
            //     ),
            //   ),
            // ),
          ),
          SliverList(
            //เริ่มลิสยา
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DrugDetail(drugDataModel: drugData[index])));
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
    List<DrugDataModel> drugs = [];
    String baseURL = 'https://sv1.p0nd.dev/drugScanner/?';
    if (search != null) {
      baseURL += '&search=$search';
    }
    if (type != null && type != "All") {
      baseURL += '&type=$type';
    }
    if (color != null && color != "All") {
      baseURL += '&color=$color';
    }
    if (shape != null && shape != "All") {
      baseURL += '&shape=$shape';
    }
    print(baseURL);
    Uri url = Uri.parse(baseURL);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) {
        drugs.add(DrugDataModel(
            id: key,
            name: value["name"],
            image: value.containsKey("image") ? value["image"] : null,
            type: value["type"],
            color: value["appearance"]["color"].toString().replaceAll("[", "").replaceAll("]", ""),
            shape: value["appearance"]["shape"],
            alias: value["alias"],
            usedFor: value["for"],
            usage: value["usage"]));
      });
    }
    setState(() {
      drugData = drugs;
      appBarTitle = Text(
        'พบผลการค้นหาทั้งหมด ${drugData.length} รายการ',
        style: const TextStyle(fontSize: 18),
      );
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
                    borderRadius: const BorderRadius.only(
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
