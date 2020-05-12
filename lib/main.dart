import 'dart:convert';

import 'package:sewaki/pages/category_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(accentColor: Colors.lightGreen),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

String getId;
List data;
String langName;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = 'http://calm-crag-08514.herokuapp.com/language';

  // ignore: missing_return
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData['language'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: Text(
          'SeWaki',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.navigate_next),
//        backgroundColor: Colors.lightGreen,
//        onPressed: (){
//
//        },
//      ),
      body: Container(
        child: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Divider(
                  height: 0.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/covid19.png'),
                  ),
                  title: Text(data[index]['lang_name']),
                  onTap: () {
                    setState(() {
                      getId = data[index]['lang_code'];
                      langName = data[index]['lang_name'];
                      print(langName);
                      print(getId);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryList()));
                  },
                ),
                Divider(
                  height: 0.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
