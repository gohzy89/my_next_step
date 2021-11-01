import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './loginpage.dart';
import './settings.dart';
import './PreferencePage.dart';
import './recommended.dart';
import './accinfo.dart';
import './favourites.dart';
import './browse.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 
  Widget settingbtn(bool status) {
    if(status)
    return  IconButton(icon: Icon(Icons.settings),onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => settings()));
      },iconSize: 40,);
    else
      return IconButton(icon: Icon(Icons.settings),onPressed: null,iconSize: 40,);
  }

  Widget sulibtn(bool status){
    if(!status)
      return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width * 0.95,
          alignment: Alignment.topLeft,
          child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.white),),
              onPressed: () {Navigator.pop(context);}, child: Text("Sign up | Login",style: TextStyle(color: Colors.black),))
      );
    else
      return Card();
  }
  Widget favbtn(bool status){
    if(status)
      return ElevatedButton.icon(
        onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => favourite()));},
        icon: Icon(Icons.star,size: 50,color: Colors.yellow,),
        label: Text("Favourite",style: TextStyle(fontSize: 40,color: Colors.black),),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(6),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            alignment: Alignment.centerLeft,
            fixedSize: MaterialStateProperty.all(Size(270,110)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red,width: 3)
                )
            )
        ),
      );
    else
      return ElevatedButton.icon(
        onPressed: null,
        icon: Icon(Icons.star,size: 50,color: Colors.grey,),
        label: Text("Favourite",style: TextStyle(fontSize: 40,color: Colors.grey),),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            alignment: Alignment.centerLeft,
            fixedSize: MaterialStateProperty.all(Size(270,110)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey,width: 3)
                )
            )
        ),
      );
  }

  Widget recommendbtn(bool status){
    if(status)
    return ElevatedButton.icon(
      onPressed:
          () {accinfo.generaterrecommendedlist();Navigator.push(context,MaterialPageRoute(builder: (context) => recommend()));print(accinfo.recommendedlist);print(accinfo.recommendedlistcutoff);print(accinfo.recommendedlistalphabet);},
      icon: Icon(Icons.list,size: 50,color: Colors.black,),
      label: Container(width: MediaQuery.of(context).size.width*0.4,child: Text("Courses for you",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(6),
        backgroundColor: MaterialStateProperty.all(Colors.white),
          alignment: Alignment.centerLeft,
          fixedSize: MaterialStateProperty.all(Size(270,110)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red,width: 3)
              )
          )
      ),

    );
    else
      return ElevatedButton.icon(
        onPressed: null,
        icon: Icon(Icons.list,size: 50,color: Colors.grey,),
        label: Container(width: MediaQuery.of(context).size.width*0.4,child: Text("Courses for you",style: TextStyle(fontSize: 35,color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            alignment: Alignment.centerLeft,
            fixedSize: MaterialStateProperty.all(Size(270,110)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey,width: 3)
                )
            )
        ),

      );

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
          child: SafeArea(
            child: Stack(
              children: [
                sulibtn(accinfo.isloggedin),
               Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.topRight,
                  child: Material(child: settingbtn(accinfo.isloggedin),color: Colors.white,),
                ),
                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    recommendbtn(accinfo.isloggedin),//recommendbtn(accinfo.isloggedin && accinfo.score_a!="" && accinfo.score_a!=null),
                    ElevatedButton.icon(
                      onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => browse()));},
                      icon: Icon(Icons.search,size: 50,color: Colors.black,),
                      label: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text("Browse",style: TextStyle(fontSize: 35,color: Colors.black),),
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(6),
                        alignment: Alignment.centerLeft,
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          fixedSize: MaterialStateProperty.all(Size(270,110)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red,width: 3)
                              )
                          )
                      ),
                    ),
                    favbtn(accinfo.isloggedin),
                  ],
              ),
                ),]
            ),
          ),
          color: Colors.white,),
    );
  }
}
