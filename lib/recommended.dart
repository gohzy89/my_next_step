import 'package:flutter/material.dart';
import 'package:my_next_step/accinfo.dart';
import './selectedcourse.dart';


class recommend extends StatefulWidget {
  const recommend({Key? key}) : super(key: key);

  @override
  _recommendState createState() => _recommendState();
}

class _recommendState extends State<recommend> {
  String filtervalue = 'School';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,

            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(icon: Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);},iconSize: 40,),
                Text("Back")
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.topRight,
            child: Material(child: DropdownButton<String>(
              value: filtervalue,
              icon: const Icon(Icons.filter_list_outlined),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  filtervalue = newValue!;
                });
              },
              items: <String>['School', 'Cut-Off', 'Alphabet', 'Location']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
              ,color: Colors.white,),
          ),

          SizedBox.expand(
            child: DraggableScrollableSheet(
              maxChildSize: 0.9,
              minChildSize: 0.9,
              initialChildSize: 0.9,
              builder: (BuildContext context, ScrollController scrollController) {
                return ListView.separated(
                  controller: scrollController,
                  itemCount: accinfo.allcourse.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ListTile(

                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => selected(accinfo.allcourse.keys.elementAt(index))));
                          },
                          leading: Image.asset('assets/images/${accinfo.allcourse.keys.elementAt(index)[0]}.jpg'),
                          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                          tileColor: Colors.grey[70],
                          //shape: RoundedRectangleBorder(
                              //borderRadius: BorderRadius.circular(18.0),
                             // side: BorderSide(color: Colors.red,width: 3)
                         // )
                          //,
                          title: Text("School: ${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["school_name"]} \nCourse: ${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseName"]}\nCut-off:${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseCutOff"]}")),
                    );
                  },
                  separatorBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        height: 1,
                        color: Colors.grey,
                      ),
                    );
                  },

                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
