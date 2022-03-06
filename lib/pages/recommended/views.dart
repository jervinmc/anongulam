import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  final List<String> imgList = [
  'https://anongulam.s3.amazonaws.com/pic1.jpeg',
  'https://anongulam.s3.amazonaws.com/pic10.jpeg',
  'https://anongulam.s3.amazonaws.com/pic11.png',
  'https://anongulam.s3.amazonaws.com/pic12.png',
  'https://anongulam.s3.amazonaws.com/pic14.jpeg',
  'https://anongulam.s3.amazonaws.com/pic19.png'
];
  bool _load =false;
    List data_breakfast = [];
    List data_lunch = [];
    List data_dinner = [];
   static String BASE_URL = '' + Global.url + '/menu_list';
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    var category = prefs.getString("category");
    final response = await http.get(
        Uri.parse(BASE_URL + '/' + 'breakfast' + '/' + '${category}'),
        headers: {"Content-Type": "application/json"});
        final response_lunch = await http.get(
        Uri.parse(BASE_URL + '/' + 'lunch' + '/' + '${category}'),
        headers: {"Content-Type": "application/json"});
        final response_dinner = await http.get(
        Uri.parse(BASE_URL + '/' + 'dinner' + '/' + '${category}'),
        headers: {"Content-Type": "application/json"});
        setState(() {
            try {
              _load = false;
              data_breakfast = json.decode(response.body);
              data_lunch = json.decode(response_lunch.body);
              data_dinner = json.decode(response_dinner.body);
              imgList[0] = data_dinner[0][2];
              imgList[1] = data_dinner[1][2];
              imgList[2] = data_dinner[2][2];
              imgList[3] = data_breakfast[0][2];
              imgList[4] = data_breakfast[1][2];
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
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color:  Color(0xffc6782b),
              ),
            ),
            ListTile(
              title: Text('Pantry'),
              onTap: () {
                Get.toNamed('/pantry');
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xffc6782b),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Meals',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                Container(
                  padding: EdgeInsets.only(top: 15),
                    child: CarouselSlider(
                  options: CarouselOptions(),
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                                child: Image.network(item,
                                    fit: BoxFit.cover, width: 1000)),
                          ))
                      .toList(),
                )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Alternative Breakfasts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_breakfast.length,
              itemBuilder: (BuildContext context, index){
                return Column(
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 4,
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          // width: 150,
                          // height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(data_breakfast[index][2].toString(),fit: BoxFit.cover,height:100,width: 100,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details',arguments:['${data_breakfast[index][2]}','${data_breakfast[index][0]}']);
                        },
                    ),
                    Column(
                      children: [
                        Text(data_breakfast[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ),
                        
                    
                  ],
                );
            })
          ),
              Container(
                padding: EdgeInsets.all(10),
                child:  Text("Explore",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              ),
                Container(
                  height: 100,
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(20.0),
                    child: Container(
                      width: 150,
                      child: Row(children: [
                        Image.network(imgList[0]),
                        Container(
                          padding: EdgeInsets.all(10),
                          child:Column(
                          children: [
                            Text("Lorem ipsum test test lorem "),
                            Text("Lorem ipsum test test lorem ")
                          ],
                        )
                        )
                      ],),
                    )),
                ),
                Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Keto Breakfasts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_breakfast.length,
              itemBuilder: (BuildContext context, index){
                return Column(
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 4,
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          // width: 150,
                          // height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(data_breakfast[index][2].toString(),fit: BoxFit.cover, height:100, width:100),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details');
                        },
                    ),
                    Column(
                      children: [
                        Text(data_breakfast[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), 
                  ],
                );
            })
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Keto Lunch",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_lunch.length,
              itemBuilder: (BuildContext context, index){
                return Column(
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 4,
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          // width: 150,
                          // height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(data_lunch[index][2].toString(),fit: BoxFit.cover, height:100, width:100),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details');
                        },
                    ),
                    Column(
                      children: [
                        Text(data_lunch[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), 
                  ],
                );
            })
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Keto Dinner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_dinner.length,
              itemBuilder: (BuildContext context, index){
                return Column(
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 4,
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          // width: 150,
                          // height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(data_dinner[index][2].toString(),fit: BoxFit.cover, height:100, width:100),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details');
                        },
                    ),
                    Column(
                      children: [
                        Text(data_dinner[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), 
                  ],
                );
            })
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addmenu');
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffc6782b),
        child: const Icon(Icons.add),
      ),
    );
  }
}
