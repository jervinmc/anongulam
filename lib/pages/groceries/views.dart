import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  static String BASE_URL = '' + Global.url + '/pantry';
  List data = [];

  bool _load = false;

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    final response = await http.get(Uri.parse(BASE_URL + '/' + _id.toString()),
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
        title: Text('Groceries'),
        backgroundColor: Color(0xffc6782b),
      ),
      body: Container(
        child: new ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  onTap: () {
                    // Get.toNamed('/productdetails',arguments:[data[index]['product_name'],data[index]['quantity'],data[index]['price'],data[index]['id']]);
                  },
                  title: Text(data[index][1]),
                  trailing: Text("${data[index][3]}"),
                );
              },separatorBuilder: (context, index) {
                  return Divider();
                },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addGroceries');
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffc6782b),
        child: const Icon(Icons.add),
      ),
    );
  }
}
