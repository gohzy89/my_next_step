import 'dart:ui';

import 'package:flutter/material.dart';

import './selectedcourse.dart';
import './settings.dart';
import './favourites.dart';
import './reset.dart';
import './account.dart';
import './splash.dart';
import 'package:flutter/services.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'InputSubjectsPage.dart'; // for the utf8.encode method
void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'My Next Step',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        canvasColor: Colors.white,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      home: Splash(),
    );
  }
}

