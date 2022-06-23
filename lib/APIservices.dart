import 'dart:convert';

import 'package:c14190091_uas/cData.dart';
import 'package:http/http.dart' as http;

class APIservices {
  Future<List<cData>> getAllData() async {
    final response = await http.get(
      Uri.parse("https://api-berita-indonesia.vercel.app/cnbc/terbaru/")
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data']['posts'];
      return jsonResponse.map((data) => cData.fromJson(data)).toList();

    } else {
      throw Exception('Failed to Load Data');
    }
  }
}