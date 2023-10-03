import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:apis_coding/Models/model_post.dart';
import 'api_part1.dart';
import 'Models/model_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Application Interface',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var client=http.Client();
  bool isLoading=true;
  bool isError=false;
  List<ModelPost> list=[];

  @override
  void initState() {
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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