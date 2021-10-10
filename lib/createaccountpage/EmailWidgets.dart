import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'TextFieldController.dart';

class EmailWidgets extends StatefulWidget{
  @override

  _EmailWidgetsState createState() =>_EmailWidgetsState();

}

class _EmailWidgetsState extends State<EmailWidgets>{
  bool cfmEmailFlag = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: recoveryEmailFormKey,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                if(recoveryEmailFormKey.currentState!.validate()){
                  cfmEmailFlag = true;
                }else{
                  cfmEmailFlag = false;
                }
              });
            },
            controller: recoveryEmailTextEditingController,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(
                hintText: "Recovery Email",
                hintStyle: TextStyle(fontSize: 24),
                border: UnderlineInputBorder()),
            keyboardType: TextInputType.emailAddress,
            validator: (value){
                if(!EmailValidator.validate(value)){
                  return "Invalid Email";
                }
                return null;
            },
          ),
        ),
        Form(
          key: cfmRecoveryEmailFormKey,
          child: TextFormField(
            enabled: cfmEmailFlag,
            controller: confirmRecoveryEmailTextEditingController,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(
                hintText: "Confirm Recovery Email",
                hintStyle: TextStyle(fontSize: 24),
                border: UnderlineInputBorder()),
            keyboardType: TextInputType.emailAddress,
            validator: (value){
              print("validate: $value");
              if(value!=recoveryEmailTextEditingController.text)
              {
                return 'Email entered is not same';
              }
              return null;
            },
          ),
        ),
      ],
    );


  }
}