import 'package:c14190091_uas/APIservices.dart';
import 'package:c14190091_uas/cData.dart';
import 'package:c14190091_uas/DetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  APIservices serviceAPI = APIservices();
  late Future<List<cData>> listData;

  List<bool> checkLike = [];

  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    listData = serviceAPI.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home")
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: FutureBuilder<List<cData>> (
                future: listData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<cData> isiData = snapshot.data!;
                    return ListView.builder(
                      itemCount: isiData.length,
                      itemBuilder: (context, index) {
                        checkLike.add(false);
                        return Card(
                          child: ListTile(
                            title: Text(isiData[index].title),
                            leading: CircleAvatar(backgroundImage: NetworkImage(isiData[index].thumbnail),),
                            subtitle: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(isiData[index].pubDate),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        checkLike[index] = !checkLike[index];
                                        like(isiData[index], index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.thumb_up_sharp,
                                      color: checkLike[index]
                                      ? Colors.lightBlue
                                      : Colors.blueGrey
                                    )
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(detailData: isiData[index])));
                            },
                            onLongPress: () {
                              // if (checkLike[index] == false) {
                              //   checkLike[index] = true;
                              // } else if (checkLike[index] == true) {
                              //   checkLike[index] = false;
                              // }
                              // like(isiData[index], index);
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          )
        ],
      )
    );
  }

  void like(cData data, int index) async {

    if (checkLike[index] == true) {
      await firestore.collection("tbLike").doc(data.title).set(data.toJson());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berita di Like"),
      ));
    } else {
      await firestore.collection("tbLike").doc(data.title).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berita dihapus di firebase"),
      ));
    }
  }
}
