import 'dart:convert';
import 'package:anongulam/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:get/get_core/src/get_main.dart';
import 'package:tflite/tflite.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class AddPantry extends StatefulWidget {
  const AddPantry({Key? key}) : super(key: key);

  @override
  _AddPantryState createState() => _AddPantryState();
}

class _AddPantryState extends State<AddPantry> {
  bool _load = false;
  static String BASE_URL = '' + Global.url + '/pantry';
  TextEditingController name = new TextEditingController();
  TextEditingController quantity = new TextEditingController();

bool hasImage = false;


 loadMyModel()async{
    var resultant = await Tflite.loadModel(model: 
    "assets/model_unquant.tflite",labels:"assets/labels.txt");
  }
  applyModelOnImage(io.File file)async{
    var res = await Tflite.runModelOnImage(path:file.path,numResults:2,threshold: 0.5,imageMean:127.5,imageStd:127.5);
    print(res);
    setState(() {
      name.text = res![0]['label'].toString();
    });
  }
  void addToPantry() async {
    setState(() {
      _load = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var _id = prefs.getInt("_id");
    var params = {
      "name": name.text,
      "quantity": quantity.text,
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
  late  io.File selectedImage;
  String url = '';
  void runFilePiker() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
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
  @override
 void initState(){
    super.initState();
    loadMyModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu'),
        backgroundColor: Color(0xffc6782b),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                maxLength: 10,
                controller: name,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Name of Ingredients',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: quantity,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                  ),
                  hintText: 'Enter Quantity',
                ),
              ),
            ),
            new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    addToPantry();
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
                Padding(padding: EdgeInsets.only(top: 5)),
                 new SizedBox(
                width: 350.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    runFilePiker();
                    //  uploadImage();
                  },
                  child: Text('Capture Image'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffc6782b),
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
    );
  }
}
