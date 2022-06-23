import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference tbLike = FirebaseFirestore.instance.collection("tbLike");

class dbLike {
  static Stream<QuerySnapshot> getData(String judul) {
    if (judul == "") {
      return tbLike.snapshots();
    } else {
      return tbLike
        .where("title", isEqualTo: judul)
        .snapshots();
    }
    
  }
}