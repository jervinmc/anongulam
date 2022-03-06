import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class Ingredients extends StatefulWidget {
   dynamic args = Get.arguments;

  @override
  _IngredientsState createState() => _IngredientsState(this.args);
}

class _IngredientsState extends State<Ingredients> {
  final args;
  _IngredientsState(this.args);
  static String BASE_URL = '' + Global.url + '/ingredients';
  List data = [];

  bool _load = false;

  Future<String> getData() async {
    setState(() {
      _load=true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    final response = await http.get(Uri.parse(BASE_URL + '/' + args[0].toString()),
        headers: {"Content-Type": "application/json"});

    this.setState(() {
      try {
        _load = false;
        data = json.decode(response.body);
      } finally {
        _load = false;
      }
    });
    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingredients'),
        backgroundColor: Color(0xffc6782b),
      ),
      body: Column(
        children: [
          Container(
            height: 500,
        child: new ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  onTap: () {
                    // Get.toNamed('/productdetails',arguments:[data[index]['product_name'],data[index]['quantity'],data[index]['price'],data[index]['id']]);
                  },
                  title: Text(data[index][2].toString()),
                  // trailing: Text("${data[index][2]}"),
                );
              },separatorBuilder: (context, index) {
                  return Divider();
                },
            ),
      ),
        _load
                ? Container(
                    color: Colors.white10,
                    width: 70.0,
                    height: 70.0,
                    child: new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Center(
                            child: const CircularProgressIndicator())),
                  )
                : Text(''),
        ],
      )
      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
       
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Color(0xffc6782b),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
