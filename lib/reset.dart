import 'package:flutter/material.dart';

class reset extends StatefulWidget{
  const reset({Key? key}) : super(key: key);

  @override
  _resetState createState() => _resetState();
}

class _resetState extends State<reset> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final rp_einpt = TextEditingController();


  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  return Material(
  child: SafeArea(
  child: Stack(
  children: [
  Container(
  height: MediaQuery.of(context).size.height * 0.95,
  width: MediaQuery.of(context).size.width * 0.95,
  alignment: Alignment.topLeft,
  child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
  IconButton(icon: Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);},iconSize: 40,),
  Text("Back")
  ],
  ),
  ),
  Align(
  alignment: Alignment.topCenter,
  child: Padding(
  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
  child: Text("Reset Password",style: TextStyle(fontSize: 25,color: Colors.black),),
  ),
  ),
  Form(
  key: _cformkey,
  child:
  Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Align(
  alignment: Alignment.topCenter,
  child: Container(

  height: 40,
  width: 300,
  child: TextFormField(
  obscureText: false,
  decoration:
  const InputDecoration(hintText: 'Email'),
  controller: rp_einpt,
  validator: (String? value) {

  }
  ,
  ),
  ),
  ),

  Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
  onPressed: () {
  setState((){rp_einpt.text="";});
  if (_cformkey.currentState!.validate()) ;
  },
  child: Text('Reset',style: TextStyle(fontSize: 20,color: Colors.white),)),
  ),

  ],
  ),

  ),]
  ),
  ),
  )

  ;

  }
  }
