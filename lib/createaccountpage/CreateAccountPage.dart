import 'package:flutter/material.dart';
import 'package:my_next_step/InputSubjectsPage.dart';
import '../homepage.dart';
import 'EmailWidgets.dart';
import 'UsernameWidget.dart';
import 'PasswordWidgets.dart';
import 'TextFieldController.dart';
import 'package:my_next_step/accinfo.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  bool showProgess = false;
  bool enableWidgets = true;




  Future register() async {
    String url = "http://immoral-boilers.000webhostapp.com/doRegister.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": usernameTextEditingController.text,
      "password": sha1.convert(utf8.encode(confirmPasswordTextEditingController.text)).toString(),
      "email": confirmRecoveryEmailTextEditingController.text
    });
    print("isEmpty: ${response.body.isEmpty.toString()}");

    if(response.body.isEmpty==true)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Create Account Failed. Please try again."),
        ));

      }
    else
      {
        var data = json.decode(response.body);
      print("data: $data");
      if (data["result"] == 404 || data["result"] == 405) {
        print("Reason for failing: ${data["reason"]}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data["reason"]),
        ));
      }
      else {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Registration Successful"),
        ));
        accinfo.isloggedin = true;
        print(usernameTextEditingController.text);
        accinfo.username = usernameTextEditingController.text;

        accinfo.accountID = data["accountId"];
        accinfo.password = sha1.convert(utf8.encode(confirmPasswordTextEditingController.text)).toString();
        accinfo.email = confirmRecoveryEmailTextEditingController.text;

        print(accinfo.username);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(),),);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => InputSubjectsPage(),),);
      }

      }
    setState(() {
      enableWidgets = true;
      showProgess=false;
      usernameTextEditingController.text="";
      passwordTextEditingController.text="";
      confirmPasswordTextEditingController.text="";
      recoveryEmailTextEditingController.text="";
      confirmRecoveryEmailTextEditingController.text="";
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: !enableWidgets,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            print("Cancel");
                            Navigator.pop(context);
                            // pop context
                          }),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text("Create Account",
                                style: TextStyle(fontSize: 30)),
                          ),
                          UsernameWidget(), //check whether username exists
                          PasswordWidgets(), // check password valid
                          SizedBox(height: 30.0),
                          EmailWidgets(), //check email valid and email exists?
                          SizedBox(height: 40.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 6,
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode());//hide keyboard


                              print(usernameTextEditingController.text);
                              print(passwordTextEditingController.text);
                              print(confirmPasswordTextEditingController.text);
                              print(recoveryEmailTextEditingController.text);
                              print(confirmRecoveryEmailTextEditingController.text);


                              if (passwordFormKey.currentState!.validate() &
                              cfmPasswordFormKey.currentState!.validate() &
                              recoveryEmailFormKey.currentState!.validate() &
                              cfmRecoveryEmailFormKey.currentState!.validate()) {
                                //Navigator.pushNamed(context, '/InputSubjectsPage');
                                //code for create account in server
                                setState(() {
                                  enableWidgets = false;
                                  showProgess=true;
                                });

                                register();
                                print('Go to next page');


                              } else {
                                print('create acc failed');

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: const Text("Create Account Failed."),
                                ));
                              }
                            },
                          ),
                          Visibility(child: CircularProgressIndicator(),visible: showProgess,)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
// This widget is the root of your application.
}
