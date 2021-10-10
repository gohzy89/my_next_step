import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_next_step/accinfo.dart';
import 'package:my_next_step/createaccountpage/CreateAccountPage.dart';
import './reset.dart';
import './homepage.dart';


class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login>{
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final lp_uinpt = TextEditingController();
  final lp_pinpt = TextEditingController();
   bool lp_obscurepw = true;






  @override
  Widget build(BuildContext context) {
        //fetchUsers();
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Welcome!",style: TextStyle(color: Colors.black,fontSize: 30),)],),automaticallyImplyLeading: false,backgroundColor: Colors.white,shadowColor: Colors.transparent,),
        body: SafeArea(
          child: Form(
            key: _cformkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,60.0,0.0,0.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(

                      height: 40,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: 'Username'),

                        controller: lp_uinpt,
                        validator: (String? value) {

                          }
                        ,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 300,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: TextFormField(

                      obscureText: lp_obscurepw,
                      decoration:
                      InputDecoration(hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(lp_obscurepw
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                            onPressed: () {
                              setState(() {
                                lp_obscurepw = !lp_obscurepw;
                              });
                            },
                          )),
                      controller: lp_pinpt,
                      validator: (String? value) {

                        }
                      ,
                    ),
                  ),
                ),
                TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => reset()));
                setState((){lp_pinpt.text="";
                lp_uinpt.text="";});}, child: Text("Forgotten Password?")),
                ElevatedButton(
                  style: ButtonStyle(
                      //backgroundColor: MaterialStateProperty.all(Colors.white),
                      alignment: Alignment.center,
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.6,50)),

                  ),
                    onPressed: () {
                      if (_cformkey.currentState!.validate()) ;
                      accinfo.isloggedin = true;
                      setState((){lp_pinpt.text="";
                      lp_uinpt.text="";});
                      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text('Sign In',style: TextStyle(fontSize: 30),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                  child: Text("Or"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      alignment: Alignment.center,
                      fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.6,50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                              side: BorderSide(color: Colors.red,width: 1)
                          )
                      )
                  ),
                    onPressed: () {
                      setState((){lp_pinpt.text="";
                      lp_uinpt.text="";});
                      if (_cformkey.currentState!.validate()) ;
                      Navigator.push(context,MaterialPageRoute(builder: (context) => CreateAccountPage()));
                    },
                    child: Text('Sign Up',style: TextStyle(color: Colors.red,fontSize: 30),)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                  child: TextButton(onPressed: () {setState((){lp_pinpt.text="";
                  lp_uinpt.text="";});
                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));}, child: Text("Skip")),
                ),
              ],
            ),
          ),
        ),

      ),
    );

}
}