import 'package:anongulam/config/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anongulam/config/global.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  void notify(DialogType type, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
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
      "password": _password.text,
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
      notify(DialogType.SUCCES, 'Successfully Saved', '');
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
      print(_email);
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
              Container(
                  height: 100,
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Password",
                        fillColor: Colors.white70),
                  )),
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
}
