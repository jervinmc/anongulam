import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imgList = [
  'https://anongulam.s3.amazonaws.com/pic1.jpeg',
  'https://anongulam.s3.amazonaws.com/pic10.jpeg',
  'https://anongulam.s3.amazonaws.com/pic11.png',
];
String _email ='';
  bool _load =false;
    List data_breakfast = [];
    List data_lunch = [];
   String category_data = "";
    List data_dinner = [];
    String fullname = '';
    List data_recommend = [];
   static String BASE_URL = '' + Global.url + '/menu_list';
   static String BASE_URL1 = '' + Global.url + '/recommend';
   List feature = [];
  Future<String> getData() async {
       DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    print("okayyyyyyyy");
    print(now.hour);
    _load = true;
    final prefs = await SharedPreferences.getInstance();
      _email = prefs.getString("_email").toString();
    var category = prefs.getString("category");
    var _allergy = prefs.getString("_allergy");
    fullname = prefs.getString("_fullname")!;
    setState(() {
      
    });
    category_data = category!;
    
    var _id = prefs.getInt("_id");
    final response = await http.get(
        Uri.parse(BASE_URL + '/' + 'breakfast' + '/' + '${category}' +'/'+'${_allergy}'),
        headers: {"Content-Type": "application/json"});
        final response_lunch = await http.get(
        Uri.parse(BASE_URL + '/' + 'lunch' + '/' + '${category}'+'/'+'${_allergy}'),
        headers: {"Content-Type": "application/json"});
        final response_dinner = await http.get(
        Uri.parse(BASE_URL + '/' + 'dinner' + '/' + '${category}'+'/'+'${_allergy}'),
        headers: {"Content-Type": "application/json"});
        final response_recommend = await http.get(
        Uri.parse(BASE_URL1 +  '/' +_id.toString() +'/'+category),
        headers: {"Content-Type": "application/json"});
        setState(() {
            try {
              _load = false;
              data_breakfast = json.decode(response.body);
              data_lunch = json.decode(response_lunch.body);
              data_dinner = json.decode(response_dinner.body);
              data_recommend = json.decode(response_recommend.body);
              if(now.hour>6 && now.hour<11){
                  feature = data_breakfast[0];
                  // imgList[0] = data_breakfast[2][2];
                  imgList[0] = data_breakfast[0][2];
                  // imgList[1] = data_breakfast[1][2];
              }
              else if(now.hour>11 && now.hour<15){
                  feature = data_lunch[0];
                  imgList[0] = data_lunch[0][2];
                  // imgList[1] = data_lunch[0][2];
                  // imgList[2] = data_lunch[1][2];
              }
              else{
                  feature = data_dinner[0];
                  imgList[0] = data_dinner[0][2];
                  // imgList[1] = data_dinner[0][2];
                  // imgList[2] = data_dinner[1][2];
              }
          
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
              child: Column(
                children:[
                  Text('${_email}',style:TextStyle(color: Colors.white)),
                  Text('${fullname}',style:TextStyle(color: Colors.white))
                ]
              ),
              decoration: BoxDecoration(
                color:  Color(0xffc6782b),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Get.toNamed('/profile');
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Your Meals'),
              onTap: () {
                Get.toNamed('/user_meals');
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
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
              title: Text('Groceries'),
              onTap: () {
                Get.toNamed('/groceries');
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
              
                 AwesomeDialog(
                context: context,
                dialogType: DialogType.QUESTION,
                animType: AnimType.BOTTOMSLIDE,
                title: "Are you sure you want to logout?",
                desc: "",
                btnOkOnPress: () {
                  Navigator.pop(context);
                  Get.toNamed('/login');
                },
                btnCancelOnPress: (){

                }
              )..show();
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
                feature.length==0 ? Text('Loading...') :
                InkWell(
                  child:Container(
                  child:Image.network("${feature[2]}"),
                )
                ,
                onTap:() => {
                    Get.toNamed('/details',arguments:['${feature[2]}','${feature[0]}','${feature[1]}'])
                }
                ),
                 feature.length!=0 ? Column(children:[Text(feature[1],style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))],crossAxisAlignment:CrossAxisAlignment.center) : Text('')
              
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Recommended Items",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_recommend.length,
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
                              Image.network(data_recommend[index][2].toString(),fit: BoxFit.cover,height:100,width: 100,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details',arguments:['${data_recommend[index][2]}','${data_recommend[index][0]}','${data_recommend[index][1]}','${data_recommend[index][6]}']);
                        },
                    ),
                    Column(
                      children: [
                        Text(data_recommend[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text("",
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
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Text(
          //     "Alternative Breakfasts",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          //   ),
          // ),
          // _load
          //       ? Container(
          //           color: Colors.white10,
          //           width: 70.0,
          //           height: 70.0,
          //           child: new Padding(
          //               padding: const EdgeInsets.all(5.0),
          //               child: new Center(
          //                   child: const CircularProgressIndicator())),
          //         )
          //       : Text(''),
          // Container(
          //   height: 200,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: data_breakfast.length,
          //     itemBuilder: (BuildContext context, index){
          //       return Column(
          //         children: [
          //           InkWell(
          //             child: Card(
          //               elevation: 4,
          //               // color: Color(0xffc6782b),
          //               shape: RoundedRectangleBorder(
          //                 side: BorderSide(color: Colors.white70, width: 1),
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               margin: EdgeInsets.all(20.0),
          //               child: Container(
          //                 // width: 150,
          //                 // height: 185,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Image.network(data_breakfast[index][2].toString(),fit: BoxFit.cover,height:100,width: 100,),
                              
          //                     Padding(padding: EdgeInsets.only(bottom: 15))
          //                   ],
          //                 ),
          //               )),
          //               onTap: (){
          //                 Get.toNamed('/details',arguments:['${data_breakfast[index][2]}','${data_breakfast[index][0]}','${data_recommend[index][1]}']);
          //               },
          //           ),
          //           Column(
          //             children: [
          //               Text(data_breakfast[index][1],
          //                         style: TextStyle(
          //                             color: Colors.black,
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 15.0)),
          //                     Text(" ",
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           fontWeight: FontWeight.bold,
          //                         )),
          //             ],
          //           ),
                        
                    
          //         ],
          //       );
          //   })
          // ),
              Container(
                padding: EdgeInsets.all(10),
                child:  Text("Weekly Meals",
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
                    child: InkWell(
                      onTap: (){
                        Get.toNamed('/recommended');
                      },
                      child:Container(
                      width: 150,
                      child: Row(children: [
                        Image.network(imgList[0]),
                        Container(
                          padding: EdgeInsets.all(10),
                          child:Column(
                          children: [
                            Text("For a diet meal to provide satisfactory."),
                            Text("A whole week meal.")
                          ],
                        )
                        )
                      ],),
                    )
                    )),
                ),
                Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "${category_data=='keto' ? 'keto' : category_data=='paleo' ? 'Paleo' : category_data=='pescatarian' ? 'Pescatarian' : category_data=='no pork' ? 'No Pork' : 'Vegetarian'} Breakfasts",
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
                           Get.toNamed('/details',arguments:['${data_breakfast[index][2]}','${data_breakfast[index][0]}','${data_breakfast[index][1]}','${data_breakfast[index][7]}']);
                        },
                    ),
                    Column(
                      children: [
                        Text(data_breakfast[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text(" ",
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
             "${category_data=='keto' ? 'keto' : category_data=='paleo' ? 'Paleo' : category_data=='pescatarian' ? 'Pescatarian' : category_data=='no pork' ? 'No Pork' : 'Vegetarian'} Lunch",
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
                          Get.toNamed('/details',arguments:['${data_lunch[index][2]}','${data_lunch[index][0]}','${data_lunch[index][1]}','${data_lunch[index][6]}']);
                        },
                    ),
                    Column(
                      children: [
                        Text(data_lunch[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text(" ",
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
              "${category_data=='keto' ? 'keto' : category_data=='paleo' ? 'Paleo' : category_data=='pescatarian' ? 'Pescatarian' : category_data=='no pork' ? 'No Pork' : 'Vegetarian'} Dinner",
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
                         Get.toNamed('/details',arguments:['${data_dinner[index][2]}','${data_dinner[index][0]}','${data_dinner[index][1]}','${data_dinner[index][6]}']);
                        },
                    ),
                    Column(
                      children: [
                        Text(data_dinner[index][1],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0)),
                              Text(" ",
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
