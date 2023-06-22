import 'dart:convert';

import 'dart:async';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:anongulam/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class MenuEdit extends StatefulWidget {
  // const MenuEdit({ Key? key }) : super(key: key);
  dynamic args = Get.arguments;

  @override
  _MenuEditState createState() => _MenuEditState(this.args);
}

class _MenuEditState extends State<MenuEdit> {
   final args;
  _MenuEditState(this.args);
  String url = '';
  TextEditingController name = new TextEditingController();
  TextEditingController diettype = new TextEditingController();
  TextEditingController categorytime = new TextEditingController();
  String category_select = 'breakfast';
  String diettype_select = 'keto';
  
  TextEditingController foodtype = new TextEditingController();
  List<TextEditingController> ingredients = [];
  
  
List<TextEditingController> recipes = [];
final items = ['breakfast','lunch','dinner'];
final items_1 = ['keto','vegetarian','paleo','pescatarian'];
  static String BASE_URL_UPLOAD = '' + Global.url + '/upload';
  bool _load=false;
  void _setImage() async {
    final picker = ImagePicker();
    PickedFile? selectedImage = await picker.getImage(source: ImageSource.gallery);
    // imageFile = File(pickedFile.path);
}
void deleteItem()async{
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: "Are you sure you want to delete this item?",
      desc: "",
      btnOkOnPress: () async {
        var params = {
          "id":args[1]
    };
    setState(() {
      _load=true;
    });
    final response = await http.put(Uri.parse(BASE_URL123+'/'+'1'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
        Get.toNamed('/home');
      },
      btnCancelOnPress: (){
        
      }
    )..show();
}
Object data ={};
   String BASE_URL123 = '' + Global.url + '/meals';
Future<String> getData() async {
  setState(() {
    print(args);
      category_select = args[3];
       diettype_select= args[4];
       foodtype.text= args[5];
       name.text= args[2];
  });

  print("okay");
  print(args[1]);
    setState(() {
      _load=true;
    });
    final response = await http.get(
        Uri.parse(BASE_URL123 + '/' + '${args[1]}'),
        headers: {"Content-Type": "application/json"});
    setState(() {
      try {
        _load = false;
       var data = json.decode(response.body);
        for(int x=0;x<data['ingredients'].length;x++){
          // print(data['ingredients'][0]);
          ingredients.add(TextEditingController());
          ingredients[x].text=data['ingredients'][x];
        }
        for(int x=0;x<data['recipes'].length;x++){
          // print(data['ingredients'][0]);
          recipes.add(TextEditingController());
          recipes[x].text=data['recipes'][x];
        }
        print(data);
      } finally {
        _load = false;
      }
    });
    return "";
  }
late  io.File selectedImage;
  static String BASE_URL1 = '' + Global.url + '/meals/1';
  void addMenu() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    List ingredients_list=[];
    List recipes_list=[];
    for(int x = 0; x<ingredients.length;x++){
      ingredients_list.add(ingredients[x].text);
    }
    for(int x = 0; x<recipes.length;x++){
      recipes_list.add(recipes[x].text);
    }
    var params = {
      "ingredients": ingredients_list,
      "recipe": recipes_list,
      "image":"",
      "categorytime":category_select,
      "diettype":diettype_select,
      "name": name.text,
      "foodtype": foodtype.text,
      "id": args[1],
      "user_id": prefs.getInt('_id'),
    };
    final response = await http.post(Uri.parse(BASE_URL1),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    final data = json.decode(response.body);
    // print(data);
    // print("yayaya");
    // uploadImage(data['data']);
    // print("not okay");
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
   loadMyModel()async{
    var resultant = await Tflite.loadModel(model: 
    "assets/model_unquant.tflite",labels:"assets/labels.txt");
  }
  applyModelOnImage(io.File file)async{
    var res = await Tflite.runModelOnImage(path:file.path,numResults:2,threshold: 0.5,imageMean:127.5,imageStd:127.5);
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
        await ImagePicker().getImage(source: ImageSource.gallery);
        print("not okay");

    if (pickedFile != null) {
       selectedImage = io.File(pickedFile.path);
      url = pickedFile.path;
      applyModelOnImage(io.File(pickedFile.path));
      print(url);
      print("okay");
      setState(() {
        
      });
    }
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
  void initState(){
    super.initState();
    print('HAHAHAHAH');
    getData();
    loadMyModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${args[2]}'),
        backgroundColor: Color(0xffc6782b),
      ),
      body: ListView(children: [
        Container(
        padding: EdgeInsets.only(left:15,right:15),
        child: Column(
          children: [
            Image.network(args[0]),
            // Image.file(io.File(url)),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                
                controller: name,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Name Menu',
                ),
              ),
            ),
            

            Padding(padding: EdgeInsets.only(top:15)),
               Container(
                 width: 3000,
                decoration:BoxDecoration(borderRadius:BorderRadius.circular(5),border:Border.all(color: Colors.black,width:1)),
              padding: EdgeInsets.only(top: 10),
              child:DropdownButton<String>(items: items.map(buildMenuItem).toList(),
              value:category_select,
              onChanged:(category_select)=>setState(() {
                  this.category_select = category_select!;
              }))
            ),
             Padding(padding: EdgeInsets.only(top:15)),
               Container(
                 width: 3000,
                decoration:BoxDecoration(borderRadius:BorderRadius.circular(5),border:Border.all(color: Colors.black,width:1)),
              padding: EdgeInsets.only(top: 10),
              child:DropdownButton<String>(items: items_1.map(buildMenuItem).toList(),
              value:diettype_select,
              onChanged:(diettype_select)=>setState(() {
                  this.diettype_select = diettype_select!;
              }))
            ),
            Padding(padding: EdgeInsets.only(top:15)),
               Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                
                controller: foodtype,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Food type : Ex. (dairy, wheat, soyfood, nuts etc. )',
                ),
              ),
            ),
            
               Padding(padding: EdgeInsets.only(top:15)),
        //  new SizedBox(
        //         width: 350.0,
        //         height: 50.0,
        //         child: ElevatedButton(
        //           onPressed: () {
        //             runFilePiker();
        //             //  uploadImage();
        //           },
        //           child: Text('Upload Image'),
        //           style: ElevatedButton.styleFrom(
        //             primary: Color(0xffc6782b),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12), // <-- Radius
        //             ),
        //           ),
        //         )),
            for ( var i in recipes ) Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: i,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
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
                  setState(() {
                    
                  });
                    //  uploadImage();
                  },
                  child: Text('Add Instructions'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffc6782b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                )),
      
               for ( var i in ingredients ) Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: i,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Name Ingredients',
                ),
              ),
            ),
            
      
            //  for ( int i=0; i<quantity.length; i++) Container(
            //   padding: EdgeInsets.only(top: 10),
            //   child: TextField(
                
            //     controller: quantity[i],
            //     decoration: const InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black, width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black45, width: 1.0),
            //       ),
            //       hintText: 'Enter Quantity',
            //     ),
            //   ),
            // ),
     
           
            
            Padding(padding: EdgeInsets.only(top: 15)),
            new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                  ingredients.add(TextEditingController());
               
                  setState(() {
                    
                  });
                    //  uploadImage();
                  },
                  child: Text('Add Ingredients'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffc6782b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
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
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                )),
                Padding(padding: EdgeInsets.only(top: 10)),
            new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    deleteItem();
                    //  uploadImage();
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffe74c3c),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
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
      ],)
    );
  
  }
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value:item,
    child: Container(padding:EdgeInsets.all(10),child:Text(item,style:TextStyle(fontSize: 15)))
  );
}