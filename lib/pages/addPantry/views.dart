import 'dart:convert';
import 'package:anongulam/config/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get_core/src/get_main.dart';
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

bool hasImage = false;



  void addToPantry() async {
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
