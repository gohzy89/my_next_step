import 'package:flutter/material.dart';
import 'package:my_next_step/PreferencePage.dart';
import 'package:http/http.dart' as http;
import 'package:my_next_step/selectedcourse.dart';

import 'dart:convert';
import 'accinfo.dart';
import 'controller.dart';

class InputSubjectsPage extends StatefulWidget {
  @override
  State<InputSubjectsPage> createState() => _InputSubjectsPageState();
}

class _InputSubjectsPageState extends State<InputSubjectsPage> {

  bool showProgess = false;
  bool enableWidgets = true;

  String cutOff = cutOffChecker();


  List scores = List.filled(4, 0, growable: false);

  List selectedSubjectValues = subjectchecker();
  List selectedGradeValues = gradechecker();


  static String cutOffChecker(){
    print(accinfo.cca_points);
    if(accinfo.cca_points!="" && accinfo.cca_points!=null)
      return accinfo.cca_points;
    return '0';
  }


  static List subjectchecker(){
    if(accinfo.selectedSubjectValues!="" && accinfo.selectedSubjectValues!=null)
      return accinfo.selectedSubjectValues.split("*");
    return [                                      'English Language',
      'Art/Art & Design',
      'Business Studies',
      'Combined Humanities',
      'Commerce'];
  }
  static List gradechecker(){
    if(accinfo.selectedGradeValues!="" && accinfo.selectedGradeValues!=null)
      return accinfo.selectedGradeValues.split("*");
    return [                                      'A1',
    'A2',
    'B3',
    'B4',
    'C5'];
  }



  Future update() async {
    setState(() {
      showProgess = true;
      enableWidgets = false;
    });

    print(accinfo.username);
    String url = "http://immoral-boilers.000webhostapp.com/updateScore.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": accinfo.username,
      "score_a": scores[0].toString(),
      "score_b": scores[1].toString(),
      "score_c": scores[2].toString(),
      "score_d": scores[3].toString(),
      "selected_subjects": selectedSubjectValues.join("*"),
      "selected_grades": selectedGradeValues.join("*"),
      "cca_points": cutOff.toString()
    });

    //print(response);
    // print("isEmpty: ${response.body.isEmpty.toString()}");
     print(response.body);
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
          // setState(() {
          //   showProgess = false;
          //   enableWidgets = true;
          // });

          setState(() {
                accinfo.score_a = scores[0].toString();
              });

          accinfo.score_a = scores[0].toString();
          accinfo.score_b = scores[1].toString();
          accinfo.score_c = scores[2].toString();
          accinfo.score_d = scores[3].toString();

          accinfo.selectedSubjectValues = selectedSubjectValues.join("*");
          accinfo.selectedGradeValues = selectedGradeValues.join("*");

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Update Successful")));
          //await Future.delayed(Duration(seconds: 1));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PreferencePage()));
        }
      } catch (e) {
        // print("Enter catch");
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
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enableWidgets,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.cancel),
                onPressed: () {
                  print("Cancel");
                  accinfo.fromsettings = false;
                  // pop context
                  Navigator.pop(context);
                }),
            Spacer(),
            TextButton(
              child: Row(
                children: [Text("Next"), Icon(Icons.arrow_forward_outlined)],
              ),
              onPressed: () {
                print(selectedSubjectValues);
                print(selectedGradeValues);
                if (selectedSubjectValues.contains(null) ||
                    selectedGradeValues.contains(null)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Input consists of null value."),
                  ));
                } else if (checkDuplicate(selectedSubjectValues)) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Duplicate Subject"),
                  ));
                } else if (!selectedSubjectValues.contains('English Language')) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Please include English Language"),
                  ));
                } else {
                  scores[0] = computeELR2B2_A(
                      selectedSubjectValues, selectedGradeValues) -
                      int.parse(cutOff);
                  scores[1] = computeELR2B2_B(
                      selectedSubjectValues, selectedGradeValues) -
                      int.parse(cutOff);
                  scores[2] = computeELR2B2_C(
                      selectedSubjectValues, selectedGradeValues) -
                      int.parse(cutOff);
                  scores[3] = computeELR2B2_D(
                      selectedSubjectValues, selectedGradeValues) -
                      int.parse(cutOff);

                  print(scores);

                  print(selectedSubjectValues.join("*"));
                  print(selectedGradeValues.join("*"));


                  update();


                }
              },
              style: TextButton.styleFrom(primary: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [Column(
              children: [
                Container(
                  //width: MediaQuery.of(context).size.width * 0.90,
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Subjects & Grades",
                        style: TextStyle(fontSize: 25),
                      )),
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.75,
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: selectedSubjectValues.length,
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
                                        selectedSubjectValues[index] = value;
                                      });
                                    },
                                    value: selectedSubjectValues[index],
                                    items: <String>[
                                      'English Language',
                                      'Art/Art & Design',
                                      'Business Studies',
                                      'Combined Humanities',
                                      'Commerce',
                                      'Commercial Studies',
                                      'Economics',
                                      'Geography',
                                      'Higher Art',
                                      'Higher Music',
                                      'History',
                                      'Humanities (Social Studies, Literature in English)',
                                      'Humanities (Social Studies, Literature in Chinese)',
                                      'Humanities (Social Studies, Literature in Malay)',
                                      'Humanities (Social Studies, Literature in Tamil)',
                                      'Humanities (Social Studies, History)',
                                      'Humanities (Social Studies, Geography)',
                                      'Intro to Enterprise Development',
                                      'Literature in English',
                                      'Literature in Chinese',
                                      'Literature in Malay',
                                      'Literature in Tamil',
                                      'Media Studies (English)',
                                      'Media Studies (Chinese)',
                                      'Music',
                                      'Additional Mathematics',
                                      'Chinese',
                                      'Creative 3D Animation',
                                      'Design & Technology',
                                      'Design Studies',
                                      'Elementary Mathematics',
                                      'Food & Nutrition',
                                      'Higher Chinese',
                                      'Higher Malay',
                                      'Higher Tamil',
                                      'Malay',
                                      'Principles of Accounts',
                                      'Tamil',
                                      'Addn Combined Science',
                                      'Additional Science',
                                      'Biology',
                                      'Biotechnology',
                                      'Chemistry',
                                      'Combined Science',
                                      'Computing/Computer Studies',
                                      'Electronics/Fundamentals of  Electronics',
                                      'General Science',
                                      'Human & Social Biology',
                                      'Integrated Science',
                                      'Physics/Engineering Science',
                                      'Science (Chem, Bio)',
                                      'Science (Phy, Bio)',
                                      'Science (Phy, Chem, Bio)',
                                      'Science (Phy, Chem)/Physical Science',
                                    ].map<DropdownMenuItem<String>>((
                                        String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(height: 10,)
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.20,
                      //padding: EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.center,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: selectedGradeValues.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                    hint: Text("NA", textAlign: TextAlign.center),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGradeValues[index] = value;
                                      });
                                    },
                                    value: selectedGradeValues[index],
                                    items: <String>[
                                      'A1',
                                      'A2',
                                      'B3',
                                      'B4',
                                      'C5',
                                      'C6',
                                      'D7',
                                      'E8',
                                      'F9'
                                    ].map<DropdownMenuItem<String>>((
                                        String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                            value, textAlign: TextAlign.center),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    Text("CCA Points:", style: TextStyle(fontSize: 20),),
                    Container(
                      //width: MediaQuery.of(context).size.width * 0.30,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15.0),
                      //   border: Border.all(
                      //       color: Colors.red,
                      //       style: BorderStyle.solid,
                      //       width: 2.5),
                      // ),
                      child: DropdownButton<String>(
                        //isExpanded: true,
                        value: cutOff,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        //underline: SizedBox.shrink(),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            cutOff = newValue!;
                          });
                        },
                        items: <String>['0', '1', '2']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 20),),
                          );
                        }).toList(),
                      ),
                    )
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          if (selectedSubjectValues.length < 9) {
                            selectedSubjectValues.add(null);
                            selectedGradeValues.add(null);
                          }
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
                          if (selectedSubjectValues.length > 5) {
                            selectedSubjectValues.removeLast();
                            selectedGradeValues.removeLast();
                          }
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
                      child: CircularProgressIndicator(), visible: showProgess,)),
              )
            ],
          ),
        ),
      ),
    );
  }

}
