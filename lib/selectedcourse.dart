import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_next_step/accinfo.dart';
import './favourites.dart';

class selected extends StatefulWidget {
  String Code='';
  selected(String code){
    Code =code;
  }
  @override
  _selectedState createState() => _selectedState(Code);
}

class _selectedState extends State<selected> {

  String coursecode = '';
  String coursename = '';
  String school = '';
  Color? favbtncolor = Colors.black;

  _selectedState(String code){
    coursecode = code;
    coursename = accinfo.allcourse[code]["courseName"];
    school = accinfo.allcourse[code]["school_name"];
    if(accinfo.favlist.contains(coursecode)){
      favbtncolor = Colors.yellow;
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        school,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                    child: SizedBox(
                      child: Container(
                        color: Colors.black,
                      ),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(coursename+" ($coursecode)",style: TextStyle(fontSize: 25,),textAlign: TextAlign.center,)),
                      IconButton(
                          onPressed: () {
                            if(!accinfo.favlist.contains(coursecode)&&accinfo.isloggedin)
                            {
                              accinfo.favlist.add(coursecode);
                            setState(() {
                              favbtncolor = Colors.yellow;
                            });
                            }
                            else{
                              if(accinfo.isloggedin)
                              setState(() {
                                accinfo.favlist.removeAt(accinfo.favlist.indexOf(coursecode));
                                favbtncolor = Colors.black;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.bookmark_add_outlined,
                            color: favbtncolor,
                            size: 50,
                          ))

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                    child: SizedBox(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    child: DraggableScrollableSheet(
                        maxChildSize: 1,
                        minChildSize: 1,
                        initialChildSize: 1,
                      builder: (context,scrollController) {
                          return ListView(
                            children: [
                              Container(
                        child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width*0.98,

                                  child: Text(accinfo.allcourse[coursecode]["courseSchool"],style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),textAlign: TextAlign.center,)),
                              Container(
                                  width: MediaQuery.of(context).size.width*0.95,

                                  child: Text(accinfo.allcourse[coursecode]["courseDescription"],style: TextStyle(),textAlign: TextAlign.center,))
                            ],
                        ),
                      )]
                          );}
                    ),
                  ),

                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width*0.98,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/${coursecode[0]}.jpg',
                    height: MediaQuery.of(context).size.width * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                  )),
              Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                        if(accinfo.fromfav){
                          Navigator.pop(context);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => favourite()));
                        accinfo.fromfav = false;}
                        // pop context
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
