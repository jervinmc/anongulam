import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class Details extends StatefulWidget {
  dynamic args = Get.arguments;

  @override
  _DetailsState createState() => _DetailsState(this.args);
}

class _DetailsState extends State<Details> {
  final args;
  _DetailsState(this.args);
  bool _load = false;
  List data = [];
  static String BASE_URL = '' + Global.url + '/recipe';
    static String BASE_URL1 = '' + Global.url + '/likes';
  Future<String> getData() async {
    setState(() {
      _load=true;
    });
    final response = await http.get(
        Uri.parse(BASE_URL + '/' + '${args[1]}'),
        headers: {"Content-Type": "application/json"});
    setState(() {
      try {
        _load = false;
        data = json.decode(response.body);
        print(data);
      } finally {
        _load = false;
      }
    });
    return "";
  }
void addLike() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    var params = {
      "menu_id": args[1],
      "user_id": _id,
    };
    final response = await http.post(Uri.parse(BASE_URL1 + '/' + '1'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    final data = json.decode(response.body);
  }
  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${args[2]}"),
          backgroundColor: Color(0xffc6782b),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                  height: 200,
                  width: 400,
                  child: Image.network(args[0], fit: BoxFit.cover)),
                  Positioned(child: IconButton(icon: Icon(Icons.favorite,size: 30,color: Colors.red,),onPressed: (){
                    addLike();
                     Get.toNamed('/home');
                  },),top:10,right: 10,
                  )
              ],),
              Padding(padding: EdgeInsets.only(bottom:10)),
              Container(
                height: 300,
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
                  },
                  separatorBuilder: (context, index) {
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/ingredients',arguments:[args[1]]);
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffc6782b),
        child: const Icon(Icons.emoji_food_beverage),
      ),);
  }
}
