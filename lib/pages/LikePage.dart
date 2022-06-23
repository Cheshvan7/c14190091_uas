import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  int _index = 0;

  /*@override
  void initState() {

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Liked"),
      ),
    );
  }
}
