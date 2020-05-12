import 'dart:convert';
import 'package:sewaki/pages/screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';




class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}
List catData;
String catName;
String catId;
class _CategoryListState extends State<CategoryList> {
  String url = 'http://salty-shelf-45512.herokuapp.com/category';

  // ignore: missing_return
  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var extractData = json.decode(response.body);
      catData = extractData['category'];
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
        leading: Icon(Icons.list),
        title: Text(
          'Category List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: catData == null ? 0 : catData.length,
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
                  title: Text(catData[index]['category_name']),
                  onTap: () {
                    setState(() {
                      catId = catData[index]['category_id'].toString();
                      catName = catData[index]['category_name'];
                      print(catName);
                      print(catId);
                    });
//                    String str = "Hello World!";
//                    String key = "1234567890";
//                    String encrypt_data = xxtea.encryptToString(str, key);
//                    print(encrypt_data);
//                    String msg = 'DcEFHFzObMFNSSNcWSMOdssljnEXxiBfXyOouCJUcGG0xAJhlifrDj9+IdoQ0TUV2rFt7NZAbVo5h7ADQMHhWq7wxsynO3jfuI2kD+zcP0I=';
//                    String decrypt_data = xxtea.decryptToString(msg, key);
//                    print(decrypt_data);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
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
