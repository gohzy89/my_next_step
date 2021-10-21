import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class accinfo {
  static Map allcourse = new Map();
  static Map schools = {
    "N": "Ngee Ann Polytechnic",
    "T": "Temasek Polytechnic",
    "C": "Nanyang Polytechnic",
    "R": "Republic Polytechnic",
    "S": "Singapore Polytechnic"
  };

  void mapcourse1(Map map) {
    for (int i = 0; i < map['total']; i++) {
      allcourse[map['data'][i]["courseCode"]] = map['data'][i];
      allcourse[map['data'][i]["courseCode"]]["school_name"] =
          schools[map['data'][i]["courseCode"][0]];
      inserttocutoff(map['data'][i]["courseCode"]);
      alphabetlist.add(allcourse[map['data'][i]["courseCode"]]["courseName"]);
    }
    sortalphabetlist();
  }

  void inserttocutoff(String code) {
    if (cutofflist.length == 0) {
      cutofflist.add(code);
      return;
    }
    for (int i = 0; i < cutofflist.length; i++) {
      if (int.parse(allcourse[code]["courseCutOff"]) <=
          int.parse(allcourse[cutofflist[i]]["courseCutOff"])) {
        cutofflist.insert(i, code);
        return;
      }
    }
    cutofflist.insert(cutofflist.length, code);
  }

  void sortalphabetlist() {
    Map alphabet = new Map();
    for (int i = 0; i < alphabetlist.length; i++) {
      alphabet[alphabetlist[i]] = allcourse.keys.elementAt(i);
    }
    alphabetlist.sort();
    for (int i = 0; i < alphabetlist.length; i++) {
      alphabetlist.insert(i, alphabet[alphabetlist[i]]);
      alphabetlist.removeAt(i + 1);
    }
  }

  static List<String> favlist = [];
  static List<String> cutofflist = [];
  static List<String> alphabetlist = [];
  static bool isloggedin = false;
  static bool fromsettings = false;
  static bool fromfav = false;

  static String username = "";
  static String password = "";
  static String email = "";
  static String score_a = "";

  static String score_b = "";
  static String score_c = "";
  static String score_d = "";
  static String interest = "";
}
