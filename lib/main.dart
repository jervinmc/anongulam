

import 'package:anongulam/pages/addPantry/views.dart';
import 'package:anongulam/pages/details/views.dart';
import 'package:anongulam/pages/editMeal/views.dart';
import 'package:anongulam/pages/groceries/views.dart';
import 'package:anongulam/pages/home/views.dart';
import 'package:anongulam/pages/ingredients/views.dart';
import 'package:anongulam/pages/login/views.dart';
import 'package:anongulam/pages/menu/views.dart';
import 'package:anongulam/pages/pantry/views.dart';
import 'package:anongulam/pages/profile/views.dart';
import 'package:anongulam/pages/recommended/views.dart';
import 'package:anongulam/pages/reset_password/views.dart';
import 'package:anongulam/pages/signup/views.dart';
import 'package:anongulam/pages/user_meals/views.dart';
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
        GetPage(name: "/pantry", page:()=>Pantry()),
        GetPage(name: "/details", page:()=>Details()),
        GetPage(name: "/addmenu", page:()=>MenuAdd()),
        GetPage(name: "/addpantry", page:()=>AddPantry()),
        GetPage(name: "/recommended", page:()=>Recommend()),
        GetPage(name: "/groceries", page:()=>Groceries()),
        GetPage(name: "/ingredients", page:()=>Ingredients()),
         GetPage(name: "/profile", page:()=>Profile()),
        GetPage(name: "/reset", page:()=>ResetPassword()),
        GetPage(name: "/user_meals", page:()=>UserMeals()),
        GetPage(name: "/menu_edit", page:()=>MenuEdit())
      ],
      initialRoute: "/login",
    );
  }
}
