import 'package:flutter/material.dart';
import 'package:my_next_step/controller.dart';
import 'package:my_next_step/LocationPage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_next_step/accinfo.dart';

class PreferencePage extends StatefulWidget {
  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {

  bool showProgess = false;
  bool enableWidgets = true;
  List selectedInterests = checker();


  static List checker(){
    if(accinfo.interest!=""&&accinfo.interest!=null)
      {
        if(accinfo.interest.split(",").elementAt(0).contains("School of "))
          {
            List list = [];
            for(int i = 0;i<accinfo.interest.split(",").length;i++){
              list.add(accinfo.interest.split(",").elementAt(i).replaceAll("School of ", ""));
            }
            return list;

          }

        return accinfo.interest.split(",");}
    return ["Engineering"];
  }

  Future update() async {
    setState(() {
      enableWidgets = false;
      showProgess = true;
    });
    print(accinfo.username);
    print(selectedInterests.join(','));
    String url = "http://immoral-boilers.000webhostapp.com/updateInterest.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": accinfo.username,
      "interest": selectedInterests.join(','),
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

          //await Future.delayed(Duration(seconds: 1));

          accinfo.interest = selectedInterests.join(',');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationPage(),
            ),
          );
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
      AbsorbPointer(
        absorbing: !enableWidgets,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              TextButton(
                child: Row(
                  children: [Icon(Icons.arrow_back_outlined), Text("Back")],
                ),
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              Spacer(),
              TextButton(
                child: Row(
                  children: [Text("Next"), Icon(Icons.arrow_forward_outlined)],
                ),
                onPressed: () {
                  print(selectedInterests);

                  if (selectedInterests.contains(null)) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: const Text("Input consists of null value."),
                      ));
                  } else if (checkDuplicate(selectedInterests)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Duplicate Subject"),
                    ));
                  } else {
                    update();
                  }
                },
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Preference",
                            style: TextStyle(fontSize: 25),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: selectedInterests.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 2.5),
                                  ),
                                  child: DropdownButton(
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    underline: SizedBox.shrink(),
                                    hint: Text("Choose a Subject"),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedInterests[index] = value;
                                      });
                                    },
                                    value: selectedInterests[index],
                                    items: <String>[
                                      'Business & Accountancy',
                                      'Design & Environment',
                                      'Engineering',
                                      'Film & Media Studies',
                                      'Health Sciences',
                                      'Humanities & Social Sciences',
                                      'InfoComm Technology',
                                      'Life Sciences & Chemical Technology',
                                    ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (selectedInterests.length < 3) selectedInterests
                                  .add(null);
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              if (selectedInterests.length > 1) selectedInterests
                                  .removeLast();
                            });
                          },
                          child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.black,
                              )),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
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
                        visible: showProgess,
                      )),
                )
              ],
            ),
          ),
        ),
      );

}