import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final ua_pwinpt = TextEditingController();
  final ua_cpwinpt = TextEditingController();
  final ua_opwinpt = TextEditingController();

  bool ua_obscurepw = true;
  bool ua_obscurecpw = true;
  bool ua_obscureopw = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      ua_pwinpt.text = "";
                      ua_cpwinpt.text = "";
                    });
                    Navigator.pop(context);
                  },
                  iconSize: 40,
                ),
                Text("Back")
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                "Update Password",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
          ),

          Container(
            child: Form(
              key: _cformkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,85, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          obscureText: ua_obscureopw,
                          decoration: InputDecoration(hintText: 'Old Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscureopw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscureopw = !ua_obscureopw;
                                  });
                                },
                              )
                          ),
                          controller: ua_opwinpt,
                          validator: (String? value) {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,15, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          obscureText: ua_obscurepw,
                          decoration: InputDecoration(hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscurepw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscurepw = !ua_obscurepw;
                                  });
                                },
                              )
                          ),
                          controller: ua_pwinpt,
                          validator: (String? value) {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          obscureText: ua_obscurecpw,
                          decoration:
                          InputDecoration(hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(ua_obscurecpw
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  setState(() {
                                    ua_obscurecpw = !ua_obscurecpw;
                                  });
                                },
                              )),
                          controller: ua_cpwinpt,
                          validator: (String? value) {},
                        ),
                      ),
                    ),
                  ),

                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(300, 40)),
                      ),
                      onPressed: () {
                        if (_cformkey.currentState!.validate()) ;
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),

        ]),
      ),
    );
  }
}
