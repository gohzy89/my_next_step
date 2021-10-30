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
    "4": "Nanyang Polytechnic",
    'Business & Accountancy':"0",
    'Design & Environment':"1",
    'Engineering':"2",
    'Film & Media Studies':"3",
    'Health Sciences':"4",
    'Humanities & Social Sciences':"5",
    'InfoComm Technology':"6",
    'Life Sciences & Chemical Technology':"7",

    'school of business & accountancy':'Business & Accountancy',
    'school of design & environment':'Design & Environment',
    'school of engineering':'Engineering',
    'school of film & media studies':'Film & Media Studies',
    'school of health sciences':'Health Sciences',
    'school of humanities & social sciences':'Humanities & Social Sciences',
    'school of infocomm technology':'InfoComm Technology',
    'school of life sciences & chemical technology':'Life Sciences & Chemical Technology',

    'school of business & management':'Business & Accountancy',
    'school of media & design':'Film & Media Studies',
    'school of information & digital technologies':'InfoComm Technology',
    'school of applied science':'Life Sciences & Chemical Technology',

    'school of management and communication':'Business & Accountancy',
    'school of technology for the arts':'Design & Environment',
    'school of hospitality':'Humanities & Social Sciences',
    'school of sports, health and leisure':'Humanities & Social Sciences',
    'school of infocomm':'InfoComm Technology',

    'school of business':'Business & Accountancy',
    'school of design':'Design & Environment',
    'school of information and & it':'InfoComm Technology',

    'business management':'Business & Accountancy',
    'built environment':'Design & Environment',
    'engineering':'Engineering',
    'media and design':'Film & Media Studies',
    'maritime studies':'Humanities & Social Sciences',
    'information & digital technologies':'InfoComm Technology',
    'applied sciences':'Life Sciences & Chemical Technology',
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

    recommendedlist.removeRange(0, recommendedlist.length);

    recommendedlistcutoff.removeRange(0, recommendedlistcutoff.length);

    recommendedlistalphabet.removeRange(0, recommendedlistalphabet.length);

    recommendedlistschool.removeRange(0, recommendedlistschool.length);

    if(score_a==null||score_b==null||score_c==null||score_d==null||interest==null||location==null)
      return;

    for(int i=0;i<allcourse.length;i++){
      recommendedlist.add(allcourse.keys.elementAt(i));
      recommendedlistschool.add(allcourse.keys.elementAt(i));
      recommendedlistalphabet.add(allcourse[allcourse.keys.elementAt(i)]["courseName"]);
    }


    for(int i=recommendedlist.length-1;i>=0;i--){
      switch(allcourse[recommendedlist[i]]["ELR2B2_Type"][7]){
        case "A":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_a)) {
            recommendedlist.removeAt(i);
            recommendedlistschool.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "B":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_b)) {
            recommendedlist.removeAt(i);
            recommendedlistschool.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "C":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_c)) {
            recommendedlist.removeAt(i);
            recommendedlistschool.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
        case "D":if(int.parse(allcourse[recommendedlist[i]]["courseCutOff"])<int.parse(score_d)) {
            recommendedlist.removeAt(i);
            recommendedlistschool.removeAt(i);
            recommendedlistalphabet.removeAt(i);
          }
          break;
      }
    }

    sortalphabetlist1();

    for(int i=0;i<recommendedlist.length;i++){
      inserttocutoff1(recommendedlist[i]);
      for(int j=0;j<interest.split(",").length;j++)
      {String schoolname = schools[allcourse[recommendedlist[i]]["courseSchool"].toLowerCase()];
      if(schoolname==interest.split(",")[j]) {
        recommendedlist.insert(0, recommendedlist[i]);
        recommendedlist.removeAt(i+1);
      }}
    }

    for(int i=0;i<recommendedlist.length;i++){
      for(int j=0;j<interest.split(",").length;j++)
      {String schoolname = schools[allcourse[recommendedlist[i]]["courseSchool"].toLowerCase()];
        if(schoolname==interest.split(",")[j]&&allcourse[recommendedlist[i]]["school_name"]==schools[location]) {
        recommendedlist.insert(0, recommendedlist[i]);
        recommendedlist.removeAt(i+1);
      }}
    }

  }

  static List<String> favlist = [];
  static List<String> cutofflist = [];
  static List<String> alphabetlist = [];
  static List<String> recommendedlist = [];
  static List<String> recommendedlistcutoff = [];
  static List<String> recommendedlistalphabet = [];
  static List<String> recommendedlistschool = [];


  static bool isloggedin = false;
  static bool fromsettings = false;
  static bool fromfav = false;

  static String accountID = "";
  static String username = "";
  static String password = "";
  static String email = "";
  static String score_a = "";
  static String score_b = "";
  static String score_c = "";
  static String score_d = "";
  static String interest = "";
  static String location = "0";
  static String selectedSubjectValues = "";
  static String selectedGradeValues = "";
  static String cca_points = "";
}
