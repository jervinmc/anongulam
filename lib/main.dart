

import 'package:anongulam/pages/details/views.dart';
import 'package:anongulam/pages/home/views.dart';
import 'package:anongulam/pages/login/views.dart';
import 'package:anongulam/pages/signup/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter',
      theme: ThemeData(
      ),
      getPages: [
        GetPage(name: "/login", page:()=>Login()),
        GetPage(name: "/register", page:()=>Signup()),
        GetPage(name: "/home", page:()=>Home()),
        GetPage(name: "/details", page:()=>Details()),
        // GetPage(name: "/starting", page:()=>Starting()),
        // GetPage(name: "/menu", page:()=>VegetableList()),
        // GetPage(name: "/tutorial", page:()=>Tutorial()),
        // GetPage(name: "/questionaire", page:()=>Questionaire()),
        // GetPage(name: "/results", page:()=>Results()),
        // GetPage(name: "/profile", page:()=>Profile()),
        // GetPage(name: "/startingfirst", page:()=>StartingPage()),
        // GetPage(name: "/products", page:()=>Products()),
        // GetPage(name: "/cart", page:()=>Cart()),
        // GetPage(name: "/favorites", page:()=>Favorites()),
        // GetPage(name: "/product_details", page:()=>ProductDetails()),
      ],
      initialRoute: "/login",
    );
  }
}
