import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_next_step/accinfo.dart';

class reset extends StatefulWidget {
  const reset({Key? key}) : super(key: key);

  @override
  _resetState createState() => _resetState();
}

class _resetState extends State<reset> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final rp_einpt = TextEditingController();
  bool showProgess = false;
  bool enableWidgets = true;

  Future reset_passord() async {
    setState(() {
      enableWidgets = false;
      showProgess = true;
    });

    String url = "http://immoral-boilers.000webhostapp.com/resetPassword.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": rp_einpt.text,
    });
    print(response);
    print("isEmpty: ${response.body.isEmpty.toString()}");

    if (response.body.isEmpty == true) {
      ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(
        content: Text("Reset Failed. Please try again."),
      ));
    } else {
      try {
        print(response.body.substring(0,response.body.indexOf('}')+1));
        var data = json.decode(response.body.substring(0,response.body.indexOf('}')+1));
        print("decode successfully");
        print("data: $data");
        //print("data: ${data["result"]}");
        if (data["result"] == 0) {
          print("enter result = 0");
          print("Reason for failing: ${data["reason"]}");
          ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(
            content: Text(data["reason"]),
          ));
        } else {
          ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(
            content: Text("Update Successful"),
          ));

          //await Future.delayed(Duration(seconds: 1));

          Navigator.pop(context);
        }
      } catch (e) {
        print("Enter catch");
        print(e);
        ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(
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
    // TODO: implement build
    return Scaffold(
      body: AbsorbPointer(
        absorbing: !enableWidgets,
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
                  "Reset Password",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
            Form(
              key: _cformkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 40,
                      width: 300,
                      child: TextFormField(
                        obscureText: false,
                        decoration: const InputDecoration(hintText: 'Email'),
                        controller: rp_einpt,
                        validator: (String? value) {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_cformkey.currentState!.validate()) {
                            reset_passord();
                          }
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ],
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
      ),
    );
  }
}
