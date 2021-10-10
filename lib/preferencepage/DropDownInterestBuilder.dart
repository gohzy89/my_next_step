import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownInterestsBuilder extends StatefulWidget {
  @override
  _DropDownInterestsBuilderState createState() =>
      _DropDownInterestsBuilderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownInterestsBuilderState extends State<DropDownInterestsBuilder> {
  String dropdownValue = 'NA';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.90,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: Colors.red, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        underline: SizedBox.shrink(),
        style: const TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'NA',
          'Engineering',
          'Medicine',
          'Accounting',
          'Business',
          'IT',
          'Literature',
          'Teaching',
          'Sports',
          'Humanities',
          'Economics',
          'Drama',
          'Science',
          'Mathematics',
          'Electronics',
          'Music',
          'Performance',
          'Food and Nutrition',
          'Physics',
          'Chemistry',
          'Biology',
          'Art',
          'Design & Technology',
          'Computing',
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
