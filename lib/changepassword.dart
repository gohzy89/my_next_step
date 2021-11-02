import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final ua_pwinpt = TextEditingController();
  final ua_cpwinpt = TextEditingController();
  final ua_opwinpt = TextEditingController();

  bool ua_obscurepw = true;
  bool ua_obscurecpw = true;
  bool ua_obscureopw = true;

  bool showProgess = false;
  bool enableWidgets = true;

  Future updatePassword() async {
    setState(() {
      enableWidgets = false;
      showProgess = true;
    });

    String url = "http://immoral-boilers.000webhostapp.com/changePassword.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": accinfo.username,
      "password": sha1.convert(utf8.encode(ua_pwinpt.text)).toString() ,
    });
    print(response);
    print("isEmpty: ${response.body.isEmpty.toString()}");

    if (response.body.isEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Update Failed. Please try again."),
      ));
    } else {
      try {
        var data = json.decode(response.body);
        print("data: $data");
        if (data["result"] == 0) {
          print("Reason for failing: ${data["reason"]}");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data["reason"]),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Update Successful"),
          ));

          accinfo.password = sha1.convert(utf8.encode(ua_pwinpt.text)).toString();
          await Future.delayed(Duration(seconds: 1));

          Navigator.pop(context);
        }
      } catch (e) {
        print("Enter catch");
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Unexpected error. Please try again."),
        ));
      }
    }
    setState(() {
      enableWidgets = true;
      showProgess = false;
    });
  }

  @override
  Widget build(BuildContext context) =>
     Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      ua_pwinpt.text = "";
                      ua_cpwinpt.text = "";
                    });
                    Navigator.pop(context);
                  },
                  iconSize: 40,
                ),
                Text("Back")
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                "Update Password",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            child: Form(
              key: _cformkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 95, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          obscureText: ua_obscureopw,
                          decoration: InputDecoration(
                              hintText: 'Old Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscureopw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscureopw = !ua_obscureopw;
                                  });
                                },
                              )),
                          controller: ua_opwinpt,
                          validator: (value) {
                            if(value==null) return "No input";
                            if(sha1.convert(utf8.encode(value)).toString()!=accinfo.password){
                              return 'Wrong Old Password';
                            }

                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          obscureText: ua_obscurepw,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscurepw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscurepw = !ua_obscurepw;
                                  });
                                },
                              )),
                          controller: ua_pwinpt,
                          onChanged: (value) {
                            setState(() {
                              _cformkey.currentState!.validate();
                            });
                          },
                          validator: (String? value) {
                            if(value!.length<8){
                              return 'Please enter at least 8 characters';
                            }
                            else if(value.contains(' ')){
                              return 'Please remove space';
                            }
                            else if(!value.contains(new RegExp(r'[A-Z]'))){
                              return 'Please include at least 1 upper alphabet';
                            }
                            else if(!value.contains(new RegExp(r'[a-z]'))){
                              return 'Please include at least 1 lower alphabet';
                            }
                            else if(!value.contains(new RegExp(r'[0-9]'))){
                              return 'Please include at least 1 numeric value';
                            }
                            else if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              return "Password must contains at least 1 special character";
                            }

                            return null;


                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          obscureText: ua_obscurecpw,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscurecpw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscurecpw = !ua_obscurecpw;
                                  });
                                },
                              )),
                          controller: ua_cpwinpt,
                          onChanged: (value) {
                            setState(() {
                              _cformkey.currentState!.validate();
                            });
                          },
                          validator: (String? value) {if(value!.length<8){
                            return 'Please enter at least 8 characters';
                          }
                          else if(value.contains(' ')){
                            return 'Please remove space';
                          }
                          else if(!value.contains(new RegExp(r'[A-Z]'))){
                            return 'Please include at least 1 upper alphabet';
                          }
                          else if(!value.contains(new RegExp(r'[a-z]'))){
                            return 'Please include at least 1 lower alphabet';
                          }
                          else if(!value.contains(new RegExp(r'[0-9]'))){
                            return 'Please include at least 1 numeric value';
                          }
                          else if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return "Password must contains at least 1 special character";
                          }else if(value!=ua_pwinpt.text){
                            return "Not Same Password.";
                          }
                          return null;},
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(300, 40)),
                      ),
                      onPressed: () {
                        if (_cformkey.currentState!.validate()){
                          updatePassword();
                        }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
          Center(
            child: Visibility(
              child: CircularProgressIndicator(),
              visible: showProgess,
            ),
          )
        ]),
      ),
    );
  }
