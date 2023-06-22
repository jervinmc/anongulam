import 'dart:convert';

import 'dart:async';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:anongulam/config/global.dart';
import 'package:anongulam/pages/ingredients/views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MenuAdd extends StatefulWidget {
  const MenuAdd({Key? key}) : super(key: key);

  @override
  _MenuAddState createState() => _MenuAddState();
}

class _MenuAddState extends State<MenuAdd> {
  String url = '';
  TextEditingController name = new TextEditingController();
  TextEditingController diettype = new TextEditingController();
  TextEditingController categorytime = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  String category_select = 'breakfast';
  String diettype_select = 'keto';

  String foodtype = 'none';
  List<TextEditingController> ingredients = [];
  List sizeLabel = [];

  List<TextEditingController> recipes = [];
  List<TextEditingController> quantity = [];
  
  final items = ['breakfast', 'lunch', 'dinner'];
  final items_1 = ['keto', 'vegetarian', 'paleo', 'pescatarian', 'no pork'];
  final items_2 = ['dairy', 'wheat', 'nuts', 'soy', 'sea foods', 'none'];
  final items_3 = ['ml', 'piece', 'grams', 'tbsp', 'tsp', 'cup'];
  String sizeLabels = 'piece';
  static String BASE_URL_UPLOAD = '' + Global.url + '/upload';
  bool _load = false;
  void _setImage() async {
    final picker = ImagePicker();
    PickedFile? selectedImage =
        await picker.getImage(source: ImageSource.gallery);
    // imageFile = File(pickedFile.path);
  }

  late io.File selectedImage;
  static String BASE_URL1 = '' + Global.url + '/menu_list';
  void addMenu() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    List ingredients_list = [];
    List sizelabel_list = [];
    List quantity_list = [];
    List recipes_list = [];
    for (int x = 0; x < ingredients.length; x++) {
      ingredients_list.add("${ingredients[x].text} (${sizeLabel[x]})");
    }
    for (int x = 0; x < sizeLabel.length; x++) {
      sizelabel_list.add(sizeLabel[x]);
    }

    for (int x = 0; x < recipes.length; x++) {
      recipes_list.add(recipes[x].text);
    }
    for (int x = 0; x < quantity.length; x++) {
      quantity_list.add(quantity[x].text);
    }
    var params = {
      "ingredients": ingredients_list,
      "recipe": recipes_list,
      "sizelabel": sizelabel_list,
      "quantity": quantity_list,
      "image": "",
      "calories": calories.text,
      "categorytime": category_select,
      "diettype": diettype_select,
      "name": name.text,
      "foodtype": foodtype,
      "user_id": prefs.getInt('_id'),
    };
    final response = await http.post(
        Uri.parse(BASE_URL1 + '/dinner/keto/dairy'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    final data = json.decode(response.body);
    print(data);
    print("yayaya");
    uploadImage(data['data']);
    print("not okay");
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  applyModelOnImage(io.File file) async {
    var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    print(res);
  }

  uploadImage(id) async {
    print("okayy");
    final request = http.MultipartRequest(
        "POST", Uri.parse(BASE_URL_UPLOAD + '/' + id.toString()));
    final headers = {"Content-type": "multipart/form-data"};
    request.fields['user'] = "test";
    request.files.add(http.MultipartFile('image',
        selectedImage.readAsBytes().asStream(), selectedImage.lengthSync(),
        filename: selectedImage.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    // final resJson = jsonDecode(res.body);
    // var message = resJson['message'];
    // setState(() {
    //   selectedImage = null!;
    // });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "Successfull Created !",
      desc: "",
      btnOkOnPress: () {
        Get.toNamed('/home');
      },
    )..show();
  }

  void runFilePiker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print("not okay");
    print(pickedFile);
    if (pickedFile != null) {
      selectedImage = io.File(pickedFile.path);
      url = pickedFile.path;
      // applyModelOnImage(io.File(pickedFile.path));
      // print(url);
      // print("okay");
      print('nice123');
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    loadMyModel();
  }

  static String BASE_URL = '' + Global.url + '/pantry';
  void addToMenu() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    var params = {
      "name": name.text,
      "user_id": _id,
    };
    final response = await http.post(Uri.parse(BASE_URL + '/' + '1'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    final data = json.decode(response.body);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "Successfull Created !",
      desc: "",
      btnOkOnPress: () {
        Get.toNamed('/home');
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Meal'),
          backgroundColor: Color(0xffc6782b),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Image.file(io.File(url)),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 1.0),
                        ),
                        hintText: 'Enter Name Menu',
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: calories,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 1.0),
                        ),
                        hintText: 'Enter Calories',
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                      width: 3000,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1)),
                      padding: EdgeInsets.only(top: 10),
                      child: DropdownButton<String>(
                          items: items.map(buildMenuItem).toList(),
                          value: category_select,
                          onChanged: (category_select) => setState(() {
                                this.category_select = category_select!;
                              }))),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                      width: 3000,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1)),
                      padding: EdgeInsets.only(top: 10),
                      child: DropdownButton<String>(
                          items: items_1.map(buildMenuItem).toList(),
                          value: diettype_select,
                          onChanged: (diettype_select) => setState(() {
                                this.diettype_select = diettype_select!;
                              }))),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Container(
                      width: 3000,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1)),
                      padding: EdgeInsets.only(top: 10),
                      child: DropdownButton<String>(
                          items: items_2.map(buildMenuItem).toList(),
                          value: foodtype,
                          onChanged: (foodtype) => setState(() {
                                this.foodtype = foodtype!;
                              }))),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  new SizedBox(
                      width: 350.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          runFilePiker();
                          //  uploadImage();
                        },
                        child: Text('Upload Image'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffc6782b),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )),
                  for (var i in recipes)
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: i,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 1.0),
                          ),
                          hintText: 'Enter Name Recipe',
                        ),
                      ),
                    ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  new SizedBox(
                      width: 350.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          recipes.add(TextEditingController());
                          setState(() {});
                          //  uploadImage();
                        },
                        child: Text('Add Instructions'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffc6782b),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )),
                  for (int i =0;i<ingredients.length;i++)
                   Column(
                    children: [
                       Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: ingredients[i],
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 1.0),
                          ),
                          hintText: 'Enter Name Ingredients',
                        ),
                      ),
                    ),
                       Container(
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: quantity[i],
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 1.0),
                          ),
                          hintText: 'Enter Quantity',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                          width: 3000,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          padding: EdgeInsets.only(top: 0),
                          child: DropdownButton<String>(
                              items: items_3.map(buildMenuItem).toList(),
                              value: sizeLabel[i],
                              onChanged: (val) => setState(() {
                                    this.sizeLabel[i] = val!;
                                  }))),
                    )
                    ],
                   ),
                  // for (int x=0;x<sizeLabel.length;x++)
                  //   Container(
                  //     padding: EdgeInsets.only(top: 10),
                  //     child: Container(
                  //         width: 3000,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             border:
                  //                 Border.all(color: Colors.black, width: 1)),
                  //         padding: EdgeInsets.only(top: 0),
                  //         child: DropdownButton<String>(
                  //             items: items_3.map(buildMenuItem).toList(),
                  //             value: sizeLabel[x],
                  //             onChanged: (val) => setState(() {
                  //                   this.sizeLabel[x] = val!;
                  //                 }))),
                  //   ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  new SizedBox(
                      width: 350.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          quantity.add(TextEditingController());
                          ingredients.add(TextEditingController());
                          sizeLabel.add('piece');
                          setState(() {});
                          //  uploadImage();
                        },
                        child: Text('Add Ingredients'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffc6782b),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  new SizedBox(
                      width: 350.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          addMenu();
                          //  uploadImage();
                        },
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffc6782b),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      )),
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
          ],
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Text(item, style: TextStyle(fontSize: 15))));
}
