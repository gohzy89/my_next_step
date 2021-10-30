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
        accinfo.accountID = data["accountId"];
        accinfo.username = data["username"];
        accinfo.password = data["password"];
        accinfo.email = data["email"];
        accinfo.score_a = data["score_a"];
        accinfo.score_b = data["score_b"];
        accinfo.score_c = data["score_c"];
        accinfo.score_d = data["score_d"];
        accinfo.interest = data["interest"];
        accinfo.location = data["location"];

        if(data["selected_subjects"]==null){
          accinfo.selectedSubjectValues = [
            'English Language',
            'Elementary Mathematics',
            'Additional Mathematics',
            'Science (Chem, Bio)',
            'Humanities (Social Studies, History)',
          ].join("*");
              accinfo.selectedGradeValues = [
                'A1',
                'A2',
                'B3',
                'B4',
                'C5',
              ].join("*");
        }else{
          accinfo.selectedSubjectValues = data["selected_subjects"];
          accinfo.selectedGradeValues = data["selected_grades"];
        }

        print(accinfo.username);
        print(accinfo.password);
        print(accinfo.email);
        print(accinfo.score_a);
        print(accinfo.interest);

        await getFavourite();


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



  Future getFavourite() async {

    String url = "http://immoral-boilers.000webhostapp.com/getFavouritesById.php";
    var response = await http.post(Uri.parse(url), body: {
      "accountId": accinfo.accountID,
    });
    print(response);
    print("favourite isEmpty: ${response.body.isEmpty.toString()}");

    if (response.body.isEmpty == true) {

      print("Receive Failed. Please try again.");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Receive Failed. Please try again."),
      // ));
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
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Receive Successful"),
          // ));
           print("Received Successful");
          //accinfo.favlist = data["data"]["courseCode"];
          print(data["data"]);

          for(int i = 0;i<data["total"];i++ ){
            accinfo.favlist.add(data["data"][i]["courseCode"]);
          }
  }
    } catch (e) {
    print("Enter catch");
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text("Unexpected error. Please try again."),
    ));
    }
    }

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
                          validator: (String? value) {if(value==null) return "Invalid";},
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
                        validator: (String? value) {if(value==null) return "Invalid";},
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
                          login();
                        }

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
