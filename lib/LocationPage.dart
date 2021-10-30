import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int size = 1;
  bool showProgess = false;

  bool enableWidgets = true;

  List<String> locations = ['North', 'South', 'East', 'West', 'Central'];

  String dropdownValue = ['North', 'South', 'East', 'West', 'Central'].elementAt(int.parse(accinfo.location));

  Future update() async {
    setState(() {
      showProgess = true;
      enableWidgets = false;
    });

    print(accinfo.username);
    print(locations.indexOf(dropdownValue).toString());
    String url = "http://immoral-boilers.000webhostapp.com/updateLocation.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": accinfo.username,
      "location": locations.indexOf(dropdownValue).toString(),
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
          accinfo.location = locations.indexOf(dropdownValue).toString();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Update Successful"),
          ));

          setState(() {
            showProgess = false;
            enableWidgets = true;
          });
          accinfo.location = locations.indexOf(dropdownValue).toString();

          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          // if (accinfo.fromsettings) {
          //   Navigator.pop(context);
          //   Navigator.pop(context);
          //   Navigator.pop(context);
          //   accinfo.fromsettings = false;
          // } else {
          //   accinfo.isloggedin = true;
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => HomePage()));
          // }

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
      showProgess = false;
      enableWidgets = true;
    });
  }

  @override
  Widget build(BuildContext context) =>
      AbsorbPointer(
        absorbing: !enableWidgets,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    TextButton(
                      child: Row(
                        children: [Icon(Icons.arrow_back_outlined), Text("Back")],
                      ),
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),Spacer()
                  ],
                ),
              ),
            ],
          ),
          body: Center(
            child: Stack(
              children: [Column(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.90,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Select Location",
                          style: TextStyle(fontSize: 25),
                        )),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.90,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.red,
                          style: BorderStyle.solid,
                          width: 2.5),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: SizedBox.shrink(),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: locations
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        update();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Center(
                      child: Visibility(
                        child: CircularProgressIndicator(color: Colors.red,),
                        visible: showProgess,)),
                )
              ],
            ),
          ),
        ),
      );
}