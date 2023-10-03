
import 'package:apis_coding/Models/model_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class partone extends StatefulWidget {
  const partone({super.key});

  @override
  State<partone> createState() => _partoneState();
}

class _partoneState extends State<partone> {
  var client;
  bool isLoading=true;
  bool isError=false;
  List<ModelPost> list=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }

  LoadData() async{
    isLoading=true;
    String url='https://fakestoreapi.com/products';

    Uri uri=Uri.parse(url);
    Map<String,String> header={"id":""};
    Map<String,dynamic> body={"id":1};

    Response responses=await client.get(uri);
    isLoading=false;
    if(responses.statusCode==200)
    {
      setState(() {
        list= modelPostFromMap(responses.body);
        isError=false;
      });

      print("body get successfully ${list.length}");
      print("body get successfully ${list[0].title}");
    }
    else{
      isError=true;
      if(responses.statusCode==404)
      {
        print("response sorry source not found");
      }
      else
      {
        print("sorry ${responses.statusCode}");
      }

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
      ),
      body: Container(
          child: isLoading ? CircularProgressIndicator():
          isError ? Text("Error"):
          ListView.builder(
              itemCount: list.length ,
              itemBuilder: ( context,index){
                return Column(
                  children: [
                    Text("${list[index].title}",style: TextStyle(color: Colors.red),),
                    Divider()
                  ],
                );
              })
      ),

    );
  }
}
