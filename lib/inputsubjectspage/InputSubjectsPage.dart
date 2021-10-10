import 'package:flutter/material.dart';
import 'package:my_next_step/preferencepage/PreferencePage.dart';
import 'package:my_next_step/accinfo.dart';
import 'SubjectsAndGradesBuilder.dart';


class InputSubjectsPage extends StatefulWidget {
  @override
  State<InputSubjectsPage> createState() => _InputSubjectsPageState();
}

class _InputSubjectsPageState extends State<InputSubjectsPage> {
  int size = 5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          print("Cancel");
                          accinfo.fromsettings = false;
                          Navigator.pop(context);
                        }),

                    Spacer(),
                    TextButton(
                      child: Row(
                        children: [
                          Text("Next"),
                          Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>PreferencePage()),
                      ),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Subjects & Grades",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(size, (index) {
                        return SubjectsAndGradesBuilder();
                        //DropDownGradesBuilder();
                      }),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          size++;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          if (size > 5) size--;
                        });
                      },
                      child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                          )),
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(width: 10,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
