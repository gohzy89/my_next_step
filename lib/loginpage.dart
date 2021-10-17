import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:my_next_step/createaccountpage/CreateAccountPage.dart';
import './reset.dart';
import './homepage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final lp_uinpt = TextEditingController();
  final lp_pinpt = TextEditingController();
  bool lp_obscurepw = true;

  bool showProgess = false;

  bool enableWidgets = true;


  Future login() async {
    String url = "http://immoral-boilers.000webhostapp.com/doLogin.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": lp_uinpt.text,
      "password": sha1.convert(utf8.encode(lp_pinpt.text)).toString(),
    });

    if (response.body.isEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login Failed. Please try again."),
      ));
    } else {
      var data = json.decode(response.body);
      print("data: $data");
      if (data["result"] == 0) {
        print("Reason for failing: ${data["reason"]}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data["reason"]),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login Successful"),
        ));
        accinfo.isloggedin = true;
        print(lp_uinpt.text);
        accinfo.username = lp_uinpt.text;
        print(accinfo.username);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }

    setState(() {
      enableWidgets = true;
      showProgess = false;
      lp_pinpt.text = "";
      lp_uinpt.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    //fetchUsers();
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: TextStyle(color: Colors.black, fontSize: 30),
              )
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: AbsorbPointer(
          absorbing: !enableWidgets,
          child: SafeArea(
            child: Form(
              key: _cformkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          decoration: const InputDecoration(hintText: 'Username'),
                          controller: lp_uinpt,
                          validator: (String? value) {},
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 300,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        obscureText: lp_obscurepw,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(lp_obscurepw
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined),
                              onPressed: () {
                                setState(() {
                                  lp_obscurepw = !lp_obscurepw;
                                });
                              },
                            )),
                        controller: lp_pinpt,
                        validator: (String? value) {},
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => reset()));
                          setState(() {
                            lp_pinpt.text = "";
                            lp_uinpt.text = "";
                          });

                      },
                      child: Text("Forgotten Password?")),
                  ElevatedButton(
                      style: ButtonStyle(
                        //backgroundColor: MaterialStateProperty.all(Colors.white),
                        alignment: Alignment.center,
                        fixedSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width * 0.6, 50)),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        setState(() {
                          showProgess = true;
                          enableWidgets = false;
                        });


                        if (_cformkey.currentState!.validate()) {
                          accinfo.isloggedin = true;
                        }
                        login();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 30),
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: Text("Or"),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          alignment: Alignment.center,
                          fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width * 0.6, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      side: BorderSide(
                                          color: Colors.red, width: 1)))),
                      onPressed: () {
                        setState(() {
                          lp_pinpt.text = "";
                          lp_uinpt.text = "";
                        });
                        if (_cformkey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()));
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            lp_pinpt.text = "";
                            lp_uinpt.text = "";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text("Skip")),
                  ),
                  Visibility(
                    child: CircularProgressIndicator(),
                    visible: showProgess,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
