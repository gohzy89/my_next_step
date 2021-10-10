import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownSubjectsBuilder extends StatefulWidget {
  @override
  _DropDownSubjectsBuilderState createState() =>
      _DropDownSubjectsBuilderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownSubjectsBuilderState extends State<DropDownSubjectsBuilder> {
  String dropdownValue = 'English Language';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.75,
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
          'English Language',
          'Arabic as a 3rd Language',
          'Bahasa Indonesia as a 3rd Language',
          'Literature in English',
          'History',
          'Geography',
          'Humanities (SS. Geography)',
          'Humanities (SS, History)',
          'Humanities (SS, Literature in English)',
          'Economics ^',
          'Humanities (SS, Literature in Chinese) +',
          'Humanities (SS, Literature in Malay) +',
          'Humanities (SS, Literature in Tamil) +',
          'Drama',
          'Spanish',
          'Hindi',
          'Urdu',
          'Gujarati',
          'Panjabi',
          'Bengali',
          'Burmese',
          'Thai',
          'French',
          'German',
          'Japanese [Revised]',
          'Additional Mathematics #',
          'Mathematics',
          'Additional Mathematics [Revised]',
          'Science (Physics, Chemistry)',
          'Science (Physics, Biology)',
          'Science (Chemistry, Biology)',
          'Electronics',
          'Music',
          'Higher Music',
          'Food and Nutrition #',
          'Physics',
          'Chemistry',
          'Biology',
          'Art',
          'Higher Art',
          'Design & Technology',
          'Business Studies ^',
          'Principles of Accounts [Revised]',
          'Computing',
          'Principles of Accounts #'
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
