import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  final GlobalKey<FormState> _cformkey = GlobalKey<FormState>();
  final ua_pwinpt = TextEditingController();
  final ua_cpwinpt = TextEditingController();
  final ua_reinpt = TextEditingController();
  final ua_creinpt = TextEditingController();
  final d_pwinpt = TextEditingController();
  bool ua_obscurepw = true;
  bool ua_obscurecpw = true;

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
                      ua_reinpt.text = "";
                      ua_creinpt.text = "";
                      d_pwinpt.text = "";
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
                    padding: const EdgeInsets.fromLTRB(0.0,85, 0.0, 15),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 15),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          insetPadding: EdgeInsets.all(10),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Warning!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text('Please enter your password to terminate and delete your account.',textAlign: TextAlign.center,),
                                  ),
                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.9*0.8,
                                    child: TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(hintText: 'Password'),
                                      controller: d_pwinpt,
                                      validator: (String? value) {},
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(onPressed: () => Navigator.pop(context, 'Confirm'), child: Text('Confirm',style: TextStyle(color: Colors.white),),
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.black),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    side: BorderSide(color: Colors.black,width: 3)
                                                )
                                            )
                                        ),
                                      ),
                                      ElevatedButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('Cancel',style: TextStyle(color: Colors.red),),
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.white),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(18.0),
                                                    side: BorderSide(color: Colors.red,width: 3)
                                                )
                                            )
                                        ),
                                      )
                                    ],
                                  )

                                ],
                              ),
                          )

                          ,
                        ),
                      ),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
