import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Models/model_post.dart';
import 'package:http/http.dart'as http;
class Partthree extends StatefulWidget {
  const Partthree({super.key});

  @override
  State<Partthree> createState() => _PartthreeState();
}

class _PartthreeState extends State<Partthree> {
  var client;
  List<ModelPost> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }

  @override
  Future<List<ModelPost>> LoadData() async {
    List<ModelPost>list = [];
    String url = 'https://fakestoreapi.com/products';
    Uri uri = Uri.parse(url);
    Response responses = await http.get(uri);

    if (responses.statusCode == 200) {
      list = modelPostFromMap(responses.body);
      return list;
    }
    else {
      return list;
    }
  }
}
