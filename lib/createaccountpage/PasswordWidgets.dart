import 'package:flutter/material.dart';

import 'TextFieldController.dart';

class PasswordWidgets extends StatefulWidget{
  @override

  _PasswordWidgetsState createState() => _PasswordWidgetsState();

}

class _PasswordWidgetsState extends State<PasswordWidgets>{
  bool _secureText = true;
  bool _cfmSecureText = true;
  bool cfmPasswordFlag = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: passwordFormKey,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                if(passwordFormKey.currentState!.validate()){
                  cfmPasswordFlag = true;
                }else{
                  cfmPasswordFlag = false;
                }
              });
            },
            controller: passwordTextEditingController, //check password meet requirement
            style: TextStyle(fontSize: 24),
            obscureText: _secureText,
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 24),
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_secureText
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText;
                    });
                  },
                )),
            validator: (value){
              if(value!.length<8){
                return 'Please enter at least 8 characters';
              }
              else if(value.contains(' ')){
                return 'Please remove space';
              }
              else if(!value.contains(new RegExp(r'[A-Z]'))){
                return 'Please include at least 1 upper alphabet';
              }
              else if(!value.contains(new RegExp(r'[a-z]'))){
                return 'Please include at least 1 lower alphabet';
              }
              else if(!value.contains(new RegExp(r'[0-9]'))){
                return 'Please include at least 1 numeric value';
              }
              else if (!value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return "Password must contains at least 1 special character";
              }
              return null;
            },
          ),
        ),
        Form(
          key: cfmPasswordFormKey,
          child: TextFormField(
            enabled: cfmPasswordFlag,
            controller: confirmPasswordTextEditingController, //check password same
            style: TextStyle(fontSize: 24),
            obscureText: _cfmSecureText,
            decoration: InputDecoration(
                hintText: "Confirm Password",
                hintStyle: TextStyle(fontSize: 24),
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_cfmSecureText
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined),
                  onPressed: () {
                    setState(() {
                      _cfmSecureText = !_cfmSecureText;
                    });
                  },
                )),
            validator: (value) {
              print("validate: $value");
              if(value!=passwordTextEditingController.text)
                {
                  return 'Password entered is not same';
                }
              return null;
            },
          ),
        ),
      ],
    );

  }
}