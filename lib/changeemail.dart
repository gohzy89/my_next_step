import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class changeemail extends StatefulWidget {
  const changeemail({Key? key}) : super(key: key);

  @override
  _changeemailState createState() => _changeemailState();
}

class _changeemailState extends State<changeemail> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final ua_reinpt = TextEditingController();
  final ua_creinpt = TextEditingController();

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
                      ua_reinpt.text = "";
                      ua_creinpt.text = "";
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
                "Update Account",
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
                    padding: const EdgeInsets.fromLTRB(0.0, 85, 0.0, 15),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          obscureText: false,
                          decoration:
                          const InputDecoration(hintText: 'Recovery Email'),
                          controller: ua_reinpt,
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
                          obscureText: false,
                          decoration: const InputDecoration(
                              hintText: 'Confirm Recovery Email'),
                          controller: ua_creinpt,
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
