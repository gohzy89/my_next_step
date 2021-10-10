import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import 'DropDownLocationBuilder.dart';
import 'package:my_next_step/homepage.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int size = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      child: Row(
                        children: [Icon(Icons.arrow_back_outlined), Text("Back")],
                      ),
                      onPressed: () => Navigator.pop(context),
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
                        "Select Location",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                DropDownLocationsBuilder(),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      if(accinfo.fromsettings){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        accinfo.fromsettings = false;
                      }
                      else{
                        accinfo.isloggedin = true;
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                      }
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
          ),
        ),
      ),
    );
  }
}
