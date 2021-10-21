import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class accinfo {

  static Map allcourse = new Map();
  static Map schools = {"N":"Ngee Ann Polytechnic","T":"Temasek Polytechnic","C":"Nanyang Polytechnic","R":"Republic Polytechnic","S":"Singapore Polytechnic"};

  void mapcourse1(Map map){
    for(int i=0;i<map['total'];i++){

      allcourse[map['result'][i]["courseCode"]]=map['result'][i];
      allcourse[map['result'][i]["courseCode"]]["school_name"] = schools[map['result'][i]["courseCode"][0]];
    }
  }

  static List<String> favlist = [
  ];
  static bool isloggedin = false;
  static bool fromsettings = false;
  static bool fromfav = false;

  static String username = "";
  static String password = "";
  static String email = "";
  static String score_a = "" ;
  static String score_b =  "";
  static String score_c = "";
  static String score_d = "";
  static String interest = "";

}
