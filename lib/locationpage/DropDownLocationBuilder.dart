import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownLocationsBuilder extends StatefulWidget {
  @override
  _DropDownLocationsBuilderState createState() =>
      _DropDownLocationsBuilderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownLocationsBuilderState extends State<DropDownLocationsBuilder> {
  String dropdownValue = 'North';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.90,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
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
          'North',
          'South',
          'East',
          'West',
          'Central'
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
