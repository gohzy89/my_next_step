import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownGradesBuilder extends StatefulWidget {
  @override
  _DropDownGradesBuilderState createState() =>
      _DropDownGradesBuilderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownGradesBuilderState extends State<DropDownGradesBuilder> {
  String dropdownValue = 'A1';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: Colors.red, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: SizedBox.shrink(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'A1',
          'A2',
          'B3',
          'B4',
          'C5',
          'C6',
          'D7',
          'E8',
          'F9'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
