import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './changepassword.dart';
import './changeemail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_next_step/accinfo.dart';


class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final d_pwinpt = TextEditingController();
  bool showProgess = false;
  bool enableWidgets = true;

  Future deleteAccount() async {
    setState(() {
      enableWidgets = false;
      showProgess = true;
    });

    String url = "http://immoral-boilers.000webhostapp.com/deleteAccount.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": accinfo.username,
      "password": sha1.convert(utf8.encode(d_pwinpt.text)).toString(),
    });
    print(response);
    print("isEmpty: ${response.body.isEmpty.toString()}");

    if (response.body.isEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Delete Account Failed. Please try again."),
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
            content: Text("Delete Successful"),
          ));


          accinfo.isloggedin = false;

          while(accinfo.favlist.isNotEmpty)
            accinfo.favlist.removeLast();

          while(accinfo.recommendedlist.isNotEmpty)
          {
            accinfo.recommendedlist.removeLast();
            accinfo.recommendedlistcutoff.removeLast();
            accinfo.recommendedlistalphabet.removeLast();
          }

          accinfo.accountID = "";
          accinfo.username = "";
          accinfo.password = "";
          accinfo.email = "";
          accinfo.score_a = "";
          accinfo.score_b = "";
          accinfo.score_c = "";
          accinfo.score_d = "";
          accinfo.interest = "";
          accinfo.location = "";
          accinfo.selectedSubjectValues = "";
          accinfo.selectedGradeValues = "";
          accinfo.cca_points = "";

          //await Future.delayed(Duration(seconds: 1));

          Navigator.pop(context, 'Confirm');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);

          if(Navigator.canPop(context))//create account page
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
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
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
                      d_pwinpt.text = "";
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
                "Update Account",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 100, 0.0, 0),
                  child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => changepassword()));
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(6),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            alignment: Alignment.center,
                            fixedSize: MaterialStateProperty.all(Size(350, 80)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.red, width: 3)))),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
                  child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => changeemail()));
                        },
                        child: Text(
                          "Change Email",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(6),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            alignment: Alignment.center,
                            fixedSize: MaterialStateProperty.all(Size(350, 80)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.red, width: 3)))),
                      )),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          insetPadding: EdgeInsets.all(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Warning!',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'Please enter your password to terminate and delete your account.',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width *
                                      0.9 *
                                      0.8,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: 'Password'),
                                    controller: d_pwinpt,
                                    validator: (String? value) {},
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {

                                        deleteAccount();

                                       // d_pwinpt.clear();

                                      },
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width: 3)))),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        //d_pwinpt.clear();
                                        Navigator.pop(context, 'Cancel');

                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Colors.red,
                                                      width: 3)))),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
      Center(
          child: Visibility(
            child: CircularProgressIndicator(),
            visible: showProgess,
          ),)

        ]),
      ),
    );
  }
}
