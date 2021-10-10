import 'package:flutter/material.dart';

import 'TextFieldController.dart';

class UsernameWidget extends StatefulWidget{
  @override

  _UsernameWidgetState createState() =>_UsernameWidgetState();

}

class _UsernameWidgetState extends State<UsernameWidget>{

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernameTextEditingController,
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
          //label:Text('Username',style: TextStyle(color: Colors.black),),
          hintText: "Username",
          //hintStyle: TextStyle(fontSize: 24),
          //border: UnderlineInputBorder()
          ),
      //keyboardType: TextInputType.name,
    );

  }
}