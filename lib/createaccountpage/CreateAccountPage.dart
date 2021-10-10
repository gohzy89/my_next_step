import 'package:flutter/material.dart';
import 'package:my_next_step/inputsubjectspage/InputSubjectsPage.dart';
import 'EmailWidgets.dart';
import 'UsernameWidget.dart';
import 'PasswordWidgets.dart';
import 'TextFieldController.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          print("Cancel");
                          Navigator.pop(context);
                          // pop context
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text("Create Account", style: TextStyle(fontSize: 30)),
                        ),
                        UsernameWidget(), //check whether username exists
                        PasswordWidgets(), // check password valid
                        SizedBox(height: 30.0),
                        EmailWidgets(), //check email valid and email exists?
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 6,
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: () {
                            print(usernameTextEditingController.text);
                            print(passwordTextEditingController.text);
                            print(confirmPasswordTextEditingController.text);
                            print(recoveryEmailTextEditingController.text);
                            print(confirmRecoveryEmailTextEditingController.text);




                            if (passwordFormKey.currentState!.validate() &
                            cfmPasswordFormKey.currentState!.validate() &
                            recoveryEmailFormKey.currentState!.validate() &
                            cfmRecoveryEmailFormKey.currentState!.validate()) {
                              print('Go to next page');
                              //Navigator.pushNamed(context, '/InputSubjectsPage');
                              //code for create account in server

                              //for testing
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => InputSubjectsPage()),
                              );

                            } else {
                              print('create acc failed');

                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //   content: const Text("Create Account Failed."),
                              // ));
                            }
                          },
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
// This widget is the root of your application.
}
