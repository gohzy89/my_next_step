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
    "S": "Singapore Polytechnic",
    "0": "Republic Polytechnic",
    "1": "Singapore Polytechnic",
    "2": "Temasek Polytechnic",
    "3": "Ngee Ann Polytechnic",
    "4": "Nanyang Polytechnic"
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
  static void inserttocutoff1(String code) {
    if (recommendedlistcutoff.length == 0) {
      recommendedlistcutoff.add(code);
      return;
    }
    for (int i = 0; i < recommendedlistcutoff.length; i++) {
      if (int.parse(allcourse[code]["courseCutOff"]) <=
          int.parse(allcourse[recommendedlistcutoff[i]]["courseCutOff"])) {
        recommendedlistcutoff.insert(i, code);
        return;
      }
    }
    recommendedlistcutoff.insert(recommendedlistcutoff.length, code);
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

  static void sortalphabetlist1() {
    Map alphabet = new Map();
    for (int i = 0; i < recommendedlistalphabet.length; i++) {
      alphabet[recommendedlistalphabet[i]] = recommendedlist[i];
    }

    recommendedlistalphabet.sort();

    for (int i = 0; i < recommendedlistalphabet.length; i++) {
      recommendedlistalphabet.insert(i, alphabet[recommendedlistalphabet[i]]);
      recommendedlistalphabet.removeAt(i + 1);
    }
  }

  static void  generaterrecommendedlist(){
    print(allcourse.length);
    print(score_a);
    print(score_b);
    print(score_c);
    print(score_d);
    recommendedlist.removeRange(0, recommendedlist.length);

    recommendedlistcutoff.removeRange(0, recommendedlistcutoff.length);

    recommendedlistalphabet.removeRange(0, recommendedlistalphabet.length);

    for(int i=0;i<allcourse.length;i++){
      recommendedlist.add(allcourse.keys.elementAt(i));
      recommendedlistalphabet.add(allcourse[allcourse.keys.elementAt(i)]["courseName"]);
    }


    for(int i=recommendedlist.length-1;i>=0;i--){
      switch(allcourse[recommendedlist[i]]["ELR2B2_Type"][7]){
        case "A":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_a)) {
            recommendedlist.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "B":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_b)) {
            recommendedlist.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "C":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_c)) {
            recommendedlist.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "D":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_d)) {
            recommendedlist.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
      }
    }

    sortalphabetlist1();

    for(int i=0;i<recommendedlist.length;i++){
      inserttocutoff1(recommendedlist[i]);
      if(allcourse[recommendedlist[i]]["courseSchool"]==interest) {
        recommendedlist.insert(0, recommendedlist[i]);
        recommendedlist.removeAt(i+1);
      }
    }
    for(int i=0;i<recommendedlist.length;i++){
      if(allcourse[recommendedlist[i]]["courseSchool"]==interest&&allcourse[recommendedlist[i]]["school_name"]==schools[location]) {
        recommendedlist.insert(0, recommendedlist[i]);
        recommendedlist.removeAt(i+1);
      }
    }

  }

  static List<String> favlist = [];
  static List<String> cutofflist = [];
  static List<String> alphabetlist = [];
  static List<String> recommendedlist = [];
  static List<String> recommendedlistcutoff = [];
  static List<String> recommendedlistalphabet = [];
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
  static String location = "";
}
