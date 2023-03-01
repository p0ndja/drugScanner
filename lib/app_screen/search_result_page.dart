import 'package:flutter/material.dart';

class DrugDataModel {
  final String image, name, thaiName, prop, use, storage;

  DrugDataModel(
      this.image, this.prop, this.use, this.storage, this.name, this.thaiName);
}

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
                              Text(drugDataModel.thaiName),
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

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static List<String> drugImage = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
  ];
  static List<String> drugName = [
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
  ];
  static List<String> drugThaiName = [
    'TYLENOL 500 mg.adasdasdsadsaadsa',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
  ];
  static List<String> drugProp = [
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
  ];
  static List<String> drugUse = [
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
  ];
  static List<String> drugStro = [
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
    'TYLENOL 500 mg.',
  ];
  final List<DrugDataModel> drugData = List.generate(
      drugName.length,
      (index) => DrugDataModel(
          drugImage[index],
          drugName[index],
          drugThaiName[index],
          drugProp[index],
          drugUse[index],
          drugStro[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context); }
            ),
            backgroundColor: const Color(0xff008080),
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text('หน้าค้นหา'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff008080),
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        prefix: const Padding(padding: EdgeInsets.only(left: 15)),
                        hintText: 'ค้นหาด้วยชื่อยา...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          color: const Color(0xff008080),
                          onPressed: () {},
                        ),
                        border: InputBorder.none
                    ),
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
          SliverList( //เริ่มลิสยา
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          BoxOfPill(drugData[index].image, 'ชื่อยา: ${drugData[index].name}', 'ชื่อยา: ${drugData[index].name}')
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
}

class BoxOfPill extends StatelessWidget {
  final image,name1,name2;
  const BoxOfPill(this.image, this.name1, this.name2);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8), //ระยะกล่อง
      child: Material(
        color: Colors.transparent,
        elevation: 2, //เงา
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), //ขอบโค้ง
        ),
        child: Container(
          width: 350,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row( // ของในกล่อง
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Image(
                    image: NetworkImage(image),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name1),
                    Text(name2)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}