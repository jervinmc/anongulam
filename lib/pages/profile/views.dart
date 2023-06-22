import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anongulam/config/global.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
class Profile extends StatefulWidget {
  

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static String BASE_URL = '' + Global.url + '/';
  bool _load = false;
  int _id = 0;
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
 TextEditingController _fullname = new TextEditingController();
  final items_1 = ['keto','vegetarian','paleo','pescatarian','no pork','any'];
    final items_2 = ['highblood','sugar','allergy','healthy'];
    String category_select = 'keto';
    String health_condition ='highblood';
  void notify(DialogType type, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {
          Get.toNamed('/login');
      },
    )..show();
  }

  void Save() async {
    if (_email.text == '' || _email.text == null) {
      notify(DialogType.ERROR, 'Required Field', 'Please fill up the form.');
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    var params = {
      "email": _email.text,
      // "password": _password.text,
      "category": category_select,
      "health_condition": health_condition,
      "fullname": _fullname.text,
      "id": prefs.getInt('_id')
    };
    setState(() {
      _load = true;
    });
    final response = await http.put(Uri.parse(BASE_URL + 'users/' + _id.toString()),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    String jsonsDataString = response.body.toString();
    final _data = jsonDecode(jsonsDataString);
    if (_data['status'] == 'Success') {
      prefs.setString('_email', _email.text);
      setState(() {
        _load = false;
      });
      notify(DialogType.SUCCES, 'Successfully Saved', 'Please relogin your account. Thank you!');
   
    } else {
      notify(DialogType.ERROR, 'Account is already exists.',
          "Please user other account.");
      setState(() {
        _load = false;
      });
    }
  }

  void getPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString("_email")!;
      _id = prefs.getInt("_id")!;
      _fullname.text = prefs.getString('_fullname')!;
      category_select = prefs.getString('category')!;
      health_condition = prefs.getString('health_condition')!;
    });
  }

  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Profile", style:TextStyle(fontSize: 20.0)),
           backgroundColor:Color(0xffc6782b),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset("assets/images/mainlogo.png",height: 90,),
              Text("Profile", style:TextStyle(fontSize: 17.0)),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Email",
                        fillColor: Colors.white70),
                  )),
                  Padding(padding: EdgeInsets.only(top: 20)),
                   Container(

                 width: 3000,
                decoration:BoxDecoration(borderRadius:BorderRadius.circular(5),border:Border.all(color: Colors.black,width:1)),
              padding: EdgeInsets.only(top: 0),
              child:DropdownButton<String>(items: items_1.map(buildMenuItem).toList(),
              value:category_select,
              onChanged:(category_select)=>setState(() {
                  this.category_select = category_select!;
              }))
            ),
              Padding(padding: EdgeInsets.only(top: 20)),
                   Container(

                 width: 3000,
                decoration:BoxDecoration(borderRadius:BorderRadius.circular(5),border:Border.all(color: Colors.black,width:1)),
              padding: EdgeInsets.only(top: 0),
              child:DropdownButton<String>(items: items_2.map(buildMenuItem).toList(),
              value:health_condition,
              onChanged:(health_condition)=>setState(() {
                  this.health_condition = health_condition!;
              }))
            ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: _fullname,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Email",
                        fillColor: Colors.white70),
                  )),
              // Container(
              //     height: 100,
              //     padding: EdgeInsets.only(top: 10),
              //     child: TextField(
              //       obscureText: true,
              //       controller: _password,
              //       decoration: InputDecoration(
              //           contentPadding: EdgeInsets.all(8.0),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(20.0),
              //           ),
              //           filled: true,
              //           hintStyle: TextStyle(color: Colors.grey[800]),
              //           hintText: "Password",
              //           fillColor: Colors.white70),
              //     )),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 120),
                  width: 250,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffc6782b),),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Text('Save'),
                    onPressed: () {
                      Save();
                    },
                  ),
                ),
              ),
              _load
                  ? Center(
                      child: Container(
                      color: Colors.white10,
                      width: 70.0,
                      height: 70.0,
                      child: new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Center(
                              child: new CircularProgressIndicator())),
                    ))
                  : Text("", style:TextStyle(fontSize: 0.0))
            ],
          ),
        ));
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value:item,
    child: Container(padding:EdgeInsets.all(10),child:Text(item,style:TextStyle(fontSize: 15)))
  );
}
