import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:my_next_step/InputSubjectsPage.dart';
import './account.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {

  bool showProgess = false;
  bool enableWidgets = true;

  Future logout() async {
    setState(() {
      enableWidgets = false;
      showProgess = true;
    });


    accinfo.isloggedin = false;

    while(accinfo.favlist.isNotEmpty)
      accinfo.favlist.removeLast();

    while(accinfo.recommendedlist.isNotEmpty)
    {
      accinfo.recommendedlist.removeLast();
      accinfo.recommendedlistcutoff.removeLast();
      accinfo.recommendedlistalphabet.removeLast();
    }


    accinfo.accountID = "";
    accinfo.username = "";
    accinfo.password = "";
    accinfo.email = "";
    accinfo.score_a = "";
    accinfo.score_b = "";
    accinfo.score_c = "";
    accinfo.score_d = "";
    accinfo.interest = "";
    accinfo.location = "";

    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    Navigator.pop(context);
    if(Navigator.canPop(context))//create account page
      Navigator.pop(context);


    setState(() {
      enableWidgets = true;
      showProgess = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enableWidgets,
      child: Container(
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
                                //accinfo.fromsettings = true;
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

                                logout();

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
              ),

              Center(
                child: Visibility(
                  child: CircularProgressIndicator(),
                  visible: showProgess,
                ),
              )]
          ),
        ),
      ),
    );
  }
}

