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
      appBar: AppBar(
        title: Text(drugDataModel.name),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 7.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[300]),
              child: Text(
                drugDataModel.use,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.grey[500]),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              drugDataModel.thaiName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            Text(drugDataModel.prop)
          ],
        ),
      ),
    );
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
              onPressed: () {},
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
              backgroundColor: const Color(0xff008080),
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
                          color: Color(0xff008080),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: const Color(0xff008080),
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
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                height: 130,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DrugDetail(drugDataModel: drugData[index])));
                  },
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
                ),
              );
            }, childCount: drugData.length),
          ),
        ],
      ),
    );
  }
}
