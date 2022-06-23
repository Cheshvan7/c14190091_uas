import 'package:c14190091_uas/APIservices.dart';
import 'package:c14190091_uas/cData.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final cData detailData;
  const DetailPage({Key? key, required this.detailData}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  APIservices serviceAPI = APIservices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
        children: [
          Container(
            child: Image(image: NetworkImage(widget.detailData.thumbnail)),
          ),
          Container(
            child: Text(widget.detailData.title),
          ),
          Container(
            child: Text(widget.detailData.description),
          ),
          Container(
            child: Text(widget.detailData.pubDate),
          )
        ],
      ),
    );
  }
}