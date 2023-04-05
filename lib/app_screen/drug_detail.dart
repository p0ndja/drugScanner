import 'package:flutter/material.dart';

import 'search_result_page.dart';

class DrugDetail extends StatefulWidget {
  const DrugDetail({Key? key, required this.drugDataModel}) : super(key: key);
  final DrugDataModel drugDataModel;

  @override
  _DrugDetailState createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
  @override
  Widget build(BuildContext context) {
    bool isBookmarked = false;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
          actions: [
            IconButton(
              color: Colors.white,
              icon: isBookmarked ? const Icon(Icons.bookmark_add, color: Colors.black) : const Icon(Icons.bookmark_add, color: Colors.black),
              onPressed: () {},
            ),
          ],
          elevation: 0,
          backgroundColor: widget.drugDataModel.image != null ? Colors.transparent : const Color(0xff008080),
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
