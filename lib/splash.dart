import 'dart:async';
import './loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_next_step/accinfo.dart';




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final String apiUrl1 = "https://immoral-boilers.000webhostapp.com/getAllCourses.php";

  Future<void> fetchCourse() async {

    var result1 = await http.get(Uri.parse(apiUrl1));
    setState(() {
      accinfo().mapcourse1(json.decode(result1.body));
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _returnhome();

  }
  _returnhome()async{
    fetchCourse();
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Image.asset('assets/images/home.jpg'),
      color: Colors.white,
    );
  }
}

