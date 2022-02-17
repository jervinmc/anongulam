import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
final List<String> imgList = [
  'https://anongulam.s3.amazonaws.com/pic1.jpeg',
  'https://anongulam.s3.amazonaws.com/pic10.jpeg',
  'https://anongulam.s3.amazonaws.com/pic11.png',
  'https://anongulam.s3.amazonaws.com/pic12.png',
  'https://anongulam.s3.amazonaws.com/pic14.jpeg',
  'https://anongulam.s3.amazonaws.com/pic19.png'
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
                Text('Good Morning!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
                Container(
                    child: Text('8:00AM'),
                    padding: EdgeInsets.only(top: 12, bottom: 10)),
                Container(
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
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
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic12.png",fit: BoxFit.cover,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        onTap: (){
                          Get.toNamed('/details');
                        },
                    ),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic19.png",fit: BoxFit.cover,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic19.png",fit: BoxFit.cover,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
           
              ],
            ),
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic12.png",fit: BoxFit.cover,),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/14.png",fit: BoxFit.cover),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
           
              ],
            ),
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic7.png",fit: BoxFit.cover),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        
                        // color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network("https://anongulam.s3.amazonaws.com/pic7.png",fit: BoxFit.cover),
                              
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                        
                    Positioned(child: Column(
                      children: [
                        Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                      ],
                    ), bottom: 20, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
           
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Keto Snacks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                    // Positioned(child: Text("TEAWEFWEF"), bottom: 10, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
           
              ],
            ),
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                          height: 185,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Longsilog",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              Text("10 Min",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 15))
                            ],
                          ),
                        )),
                    // Positioned(child: Text("TEAWEFWEF"), bottom: 10, left: 30)
                  ],
                ),
                Stack(
                  children: [
                    Card(
                        elevation: 4,
                        color: Color(0xffc6782b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(20.0),
                        child: Container(
                          width: 150,
                        )),
                    // Positioned(child: Text("test"),bottom:10,left:30)
                  ],
                ),
           
              ],
            ),
          ),
        ],
      ),
    );
  }
}
