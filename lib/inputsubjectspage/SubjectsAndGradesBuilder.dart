import 'package:flutter/material.dart';
import 'DropDownGradesBuilder.dart';

import 'DropDownSubjectsBuilder.dart';

class SubjectsAndGradesBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(children: [
          DropDownSubjectsBuilder(),
          SizedBox(width: 5,),
          DropDownGradesBuilder(),
        ],),
        SizedBox(height: 10,)
      ],
    );
  }

}