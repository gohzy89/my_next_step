import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:my_next_step/inputsubjectspage/InputSubjectsPage.dart';
import './account.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              accinfo.fromsettings = true;
                              Navigator.push(context,MaterialPageRoute(builder: (context) => InputSubjectsPage()));},
                            child: Text("Preferences",style: TextStyle(fontSize: 40,color: Colors.black),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                fixedSize: MaterialStateProperty.all(Size(300,70)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red,width: 3)
                                    )
                                )
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => account()));},
                            child: Text("Account",style: TextStyle(fontSize: 40,color: Colors.black),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                fixedSize: MaterialStateProperty.all(Size(300,70)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red,width: 3)
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              accinfo.isloggedin = false;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("Logout",style: TextStyle(fontSize: 20,color: Colors.black),),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.red,width: 3)
                                    )
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          ),
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              alignment: Alignment.topLeft,
              child: Material(child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);},iconSize: 40,),
                  Text("Back")
                ],
              ),color: Colors.white,),
            ),]
        ),
      ),
    );
  }
}

