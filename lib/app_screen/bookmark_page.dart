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

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
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
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
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
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DrugDetail(drugDataModel: drugData[index])));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5)),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    height: 130,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image(
                              image: NetworkImage(drugData[index].image),
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
                              Text('ชื่อยา: ${drugData[index].name}'),
                              Text('ชื่อยา: ${drugData[index].name}')
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }, childCount: drugData.length),
          ),
        ],
      ),
    );
  }
}
