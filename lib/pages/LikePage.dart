import 'package:c14190091_uas/cData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:c14190091_uas/dbLike.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  
  final _controllerSearch = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controllerSearch.addListener(onSearch);
    super.initState();
  }

  Stream<QuerySnapshot<Object?>> onSearch() {
    setState(() {
      
    });
    return dbLike.getData(_controllerSearch.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _controllerSearch,
              decoration: InputDecoration(
                labelText: "masukkan judul",
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue)
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot> (
                stream: onSearch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        DocumentSnapshot _data = snapshot.data!.docs[index];
                        String lvTitle = _data['title'];
                        String lvThumbnail = _data['thumbnail'];
                        String lvpubDate = _data['pubDate'];
                        String lvLink = _data['link'];
                        String lvDescription = _data['description'];
                        bool checkLike = true;

                        return Card(
                          child: ListTile(
                            onTap: () {},
                            title: Text(lvTitle),
                            leading: CircleAvatar(backgroundImage: NetworkImage(lvThumbnail),),
                            subtitle: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(lvpubDate),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        checkLike = !checkLike;
                                        delete(lvTitle);
                                      });
                                    },
                                    icon: Icon(Icons.delete)
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8,),
                      itemCount: snapshot.data!.docs.length
                    );
                  } else {
                    return const Center (
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color> (
                          Colors.blue,
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          )
        ],
      ),
    );
    
  }

  void delete (String title) async {
    await firestore.collection("tbLike").doc(title).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berita dihapus di firebase"),
      ));
  }
}
