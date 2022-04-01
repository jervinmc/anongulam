import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:anongulam/config/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

int _surveyIndex = 0;

class _SignupState extends State<Signup> {
  String isketo = 'no';
  String isany = 'no';
  String isvegetarian = 'no';
  String ispaleo = 'no';
  String ispescatarian = 'no';
  String heath_condition = '';
  bool isReveal =true;
  String allergy = 'None';

  void notify(DialogType type, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        if (DialogType.ERROR == type) {
        } else {
          Get.toNamed('/login');
        }
      },
    )..show();
  }

  TextEditingController _password = new TextEditingController();
  static String BASE_URL = '' + Global.url + '/register';
  TextEditingController _email = new TextEditingController();
    TextEditingController _confirm_password = new TextEditingController();
  bool _load = false;
  void SignUp() async {
    if(_password.text!=_confirm_password.text){
       notify(DialogType.ERROR, 'Password does not match.',
          '');
          return;
    }
    if (_email.text == null ||
        _password.text == null ||
        _email.text == '' ||
        _password.text == '') {
      return;
    }
    var params = {
      "email": _email.text,
      "password": _password.text,
      "isketo": isketo,
      "isvegetarian": isvegetarian,
      "ispaleo": ispaleo,
      "isany": isany,
      "ispescatarian": ispescatarian,
      "allergy": allergy,
    };
    setState(() {
      _load = true;
    });
    final response = await http.post(Uri.parse(BASE_URL),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    if (response.statusCode == 201) {
      setState(() {
        _load = false;
      });
      notify(DialogType.SUCCES, 'Successfully Created',
          'You may now enjoy your account.');
      _email.text = "";
      _password.text = "";
    } else {
      notify(DialogType.ERROR, 'Account is already exists.',
          "Please use other account.");
      setState(() {
        _load = false;
      });
    }
  }
  void initState(){
    super.initState();
    _surveyIndex = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _surveyIndex == 0
                ? Container(
                    child: Column(
                      children: [
                        Text('Do you prefer specific diet?',
                            style: TextStyle(
                                color: Color(0xffc6782b),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold)),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          width: 250,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xffc6782b)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            child: Text('Yes, Please'),
                            onPressed: () {
                              setState(() {
                                _surveyIndex = 1;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          width: 250,
                          child: ElevatedButton(
                            child: Text(
                              "No, I'm not picky",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                isany = 'yes';
                                _surveyIndex = 3;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                primary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  )
                : _surveyIndex == 1
                    ? Container(
                        child: Column(
                          children: [
                            Text('Which diet do you prefer?',
                                style: TextStyle(
                                    color: Color(0xffc6782b),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              width: 250,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            isketo == 'no'
                                                ? Color(0xffc6782b)
                                                : Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text('Ketogenic'),
                                onPressed: () {
                                  setState(() {
                                    isketo = 'yes';
                                    _surveyIndex = 3;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              width: 250,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            isvegetarian == 'no'
                                                ? Color(0xffc6782b)
                                                : Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text('Vegetarian'),
                                onPressed: () {
                                  setState(() {
                                    isvegetarian = 'yes';
                                    _surveyIndex = 3;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              width: 250,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ispaleo == 'no'
                                                ? Color(0xffc6782b)
                                                : Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text('Paleo'),
                                onPressed: () {
                                  setState(() {
                                    ispaleo = 'yes';
                                    _surveyIndex = 3;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              width: 250,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ispescatarian == 'no'
                                                ? Color(0xffc6782b)
                                                : Colors.black),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text('Pescatarian'),
                                onPressed: () {
                                  setState(() {
                                    ispescatarian = 'yes';
                                    _surveyIndex = 3;
                                  });
                                },
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.only(top: 5),
                            //   width: 250,
                            //   child: ElevatedButton(
                            //     child: Text(
                            //       "Proceed",
                            //       style: TextStyle(color: Colors.black),
                            //     ),
                            //     onPressed: () {
                            //       setState(() {
                            //         _surveyIndex = 3;
                            //       });
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(18.0),
                            //         ),
                            //         primary: Colors.white,
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal: 25, vertical: 10),
                            //         textStyle: TextStyle(
                            //             fontSize: 15,
                            //             fontWeight: FontWeight.bold)),
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    : _surveyIndex == 3
                        ? Container(
                            child: Column(
                              children: [
                                Text('Do you have medical conditions',
                                    style: TextStyle(
                                        color: Color(0xffc6782b),
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  width: 250,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xffc6782b)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    child: Text('Yes'),
                                    onPressed: () {
                                      print("test");
                                      setState(() {
                                        print('test');
                                        _surveyIndex = 4;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  width: 250,
                                  child: ElevatedButton(
                                    child: Text(
                                      "No, I'm healthy",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _surveyIndex = 6;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        primary: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _surveyIndex == 4
                            ? Container(
                                child: Column(
                                  children: [
                                    Text(
                                        'Which medical conditions do you have?',
                                        style: TextStyle(
                                            color: Color(0xffc6782b),
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      width: 250,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xffc6782b)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        child: Text('Highblood Pressure'),
                                        onPressed: () {
                                          setState(() {
                                            heath_condition = 'highblood';
                                            allergy = 'fatty';
                                            print('test');
                                            _surveyIndex = 6;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      width: 250,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xffc6782b)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        child: Text('Diabetic'),
                                        onPressed: () {
                                          print("test");
                                          allergy='sugar';
                                          setState(() {
                                            print('test');
                                            _surveyIndex = 6;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      width: 250,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xffc6782b)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        child: Text('Food Allergies'),
                                        onPressed: () {
                                          print("test");
                                          setState(() {
                                            print('test');
                                            _surveyIndex = 5;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : _surveyIndex == 5
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text('Which foods are you allergic to?',
                                            style: TextStyle(
                                                color: Color(0xffc6782b),
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          width: 250,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffc6782b)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                            child: Text(
                                                'Sea foods (prawns, fish, oysters, etc.)'),
                                            onPressed: () {
                                              setState(() {
                                                allergy = 'seafood';
                                                _surveyIndex = 6;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          width: 250,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Dairy (cheese, milk, cream, etc.)",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                allergy = 'dairy';
                                                _surveyIndex = 6;
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffc6782b)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          width: 250,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Nuts (peanuts, walnuts, cashews, etc.)",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                allergy = 'nuts';
                                                _surveyIndex = 6;
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffc6782b)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          width: 250,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Soy foods (Soybeans, soy sauce, soy drinks, etc.)",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                 allergy = 'soy foods';
                                                _surveyIndex = 6;
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffc6782b)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          width: 250,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Wheat (bread, cereal, oatmeal, etc.)",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                 allergy = 'wheat';
                                                _surveyIndex = 6;
                                              });
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffc6782b)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : _surveyIndex == 6
                                    ? Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/logo.jpeg",
                                              height: 200,
                                            ),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: TextField(
                                                  controller: _email,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.purple,
                                                            width: 5.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      hintText: "Email",
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                            Container(
                                                height: 70,
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: TextField(
                                                  
                                                  obscureText: isReveal,
                                                  controller: _password,
                                                  decoration: InputDecoration(
                                                    suffixIcon:!isReveal ? InkWell(
                                                      child: Icon(Icons.remove_red_eye),
                                                      onTap:()=>{
                                                       setState(() {
                                                        isReveal = true;
                                                      })
                                                      }
                                                    ) : InkWell(
                                                      child:Icon(Icons.remove_red_eye_sharp),
                                                      onTap: ()=>{
                                                       setState(() {
                                                        isReveal = false;
                                                      })
                                                      },
                                                    ),
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      hintText: "Password",
                                                      fillColor:
                                                          Colors.white70),
                                                )),
                                                Container(
                                                height: 100,
                                                
                                                child: TextField(
                                                  obscureText: isReveal,
                                                  controller: _confirm_password,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(8.0),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey,
                                                            width: 1.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      filled: true,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.grey[800]),
                                                      hintText: "Confirm Password",
                                                      fillColor:
                                                          Colors.white70),
                                                )),

                                            Container(
                                              padding: EdgeInsets.only(top: 15),
                                              width: 250,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Color(
                                                                0xffc6782b)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ))),
                                                child: Text('Signup'),
                                                onPressed: () {
                                                  SignUp();
                                                  // Login();
                                                  // Get.toNamed('/home');
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 5),
                                              width: 250,
                                              child: ElevatedButton(
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _surveyIndex = 0;
                                                  Get.toNamed('/login');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                    ),
                                                    primary: Colors.white,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25,
                                                            vertical: 10),
                                                    textStyle: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            //  _load ? Container(
                                            //   color: Colors.white10,
                                            //   width: 70.0,
                                            //   height: 70.0,
                                            //   child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
                                            // ) : Text('')
                                          ],
                                        ),
                                      )
                                    : Container(
                                      child:Text("")
                                    )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Color(0xffc6782b),
      ),
    );
  }
}
