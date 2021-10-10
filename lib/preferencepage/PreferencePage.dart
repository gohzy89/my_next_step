import 'package:flutter/material.dart';
import 'package:my_next_step/locationpage/LocationPage.dart';

import 'DropDownInterestBuilder.dart';


class PreferencePage extends StatefulWidget {
  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  int size = 1;

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
                    TextButton(
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_outlined),
                          Text("Back")
                        ],
                      ),
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(primary: Colors.black),
                    ),
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
                        MaterialPageRoute(builder: (context) =>LocationPage()),
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
                        "Preference",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(size, (index) {
                        return Column(children: [
                          DropDownInterestsBuilder(),
                          SizedBox(height: 10,)
                        ],);
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
                          if (size > 1) size--;
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
