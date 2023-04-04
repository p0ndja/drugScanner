import 'package:drug_scanner/app_screen/search_result_page.dart';
import 'package:flutter/material.dart';

class DrugDetail extends StatelessWidget {
  const DrugDetail({Key? key, required this.drugDataModel}) : super(key: key);
  final DrugDataModel drugDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            iconSize: 35,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
          actions: [
            IconButton(
              color: Colors.black,
              iconSize: 35,
              icon: const Icon(Icons.bookmark_add),
              onPressed: () {},
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
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
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 320,
                        ),
                        Container(
                            margin: const EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(drugDataModel.name)
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Column(
              children: [
                Container(
                  height: 320,
                  alignment: Alignment.center, // This is needed
                  child: Image.network(
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    'https://picsum.photos/250?image=9',
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
