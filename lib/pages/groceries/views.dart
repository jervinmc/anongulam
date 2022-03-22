import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class Groceries extends StatefulWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  _GroceriesState createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  static String BASE_URL = '' + Global.url + '/groceries';
    static String BASE_URL1= '' + Global.url + '/grocerypantry';
  List data = [];
  bool _load = false;
  List total = [];
  Future<String> getData() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    final response = await http.get(Uri.parse(BASE_URL + '/' + _id.toString()),
        headers: {"Content-Type": "application/json"});

    this.setState(() {
      try {
        _load = false;
        data = json.decode(response.body);
        for(int x=0;x<data.length;x++){
          total.add({"name":data[x][0],"quantity":data[x][1]});
        }
        _load = false;
      } finally {
        _load = false;
      }
    });
    return "";
  }


  void addToPantry() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");

    var params = {
      "user_id": _id,
      "listitem": total,
    };
    final response = await http.post(Uri.parse(BASE_URL1 ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    final data = json.decode(response.body);
     AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "Successfull Added to Pantry !",
      desc: "",
      btnOkOnPress: () {
        Get.toNamed('/home');
      },
    )..show();
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
      body: _load
                ? Container(
                    color: Colors.white10,
                    width: 70.0,
                    height: 70.0,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        new Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Center(
                            child: const CircularProgressIndicator()))
                      ],
                    ),
                  )
                : Container(
        child: new ListView.separated(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  onTap: () {
                    // Get.toNamed('/productdetails',arguments:[data[index]['product_name'],data[index]['quantity'],data[index]['price'],data[index]['id']]);
                  },
                  title: Text(data[index][0]),
                  trailing: Text("${data[index][1]}"),
                );
              },separatorBuilder: (context, index) {
                  return Divider();
                },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                animType: AnimType.BOTTOMSLIDE,
                title: "Are you sure you want to add it on the pantry?",
                desc: "",
                btnOkOnPress: () {
                  addToPantry();
                },
                btnCancelOnPress: (){}
              )..show();
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffc6782b),
        child: const Icon(Icons.add),
      ),
    );
  }
}
