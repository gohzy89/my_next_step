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

  String returnschool(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.recommendedlist[index]]["school_name"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.recommendedlistcutoff[index]]["school_name"];
      case 'Alphabet':return accinfo.allcourse[accinfo.recommendedlistalphabet[index]]["school_name"];
      case 'Location':return accinfo.allcourse[accinfo.recommendedlist[index]]["school_name"];
    }
    return "";
  }
  String returncutoff(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.recommendedlist[index]]["courseCutOff"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.recommendedlistcutoff[index]]["courseCutOff"];
      case 'Alphabet':return accinfo.allcourse[accinfo.recommendedlistalphabet[index]]["courseCutOff"];
      case 'Location':return accinfo.allcourse[accinfo.recommendedlist[index]]["courseCutOff"];
    }
    return "";
  }

  String returncourse(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.recommendedlist[index]]["courseName"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.recommendedlistcutoff[index]]["courseName"];
      case 'Alphabet':return accinfo.allcourse[accinfo.recommendedlistalphabet[index]]["courseName"];
      case 'Location':return accinfo.allcourse[accinfo.recommendedlist[index]]["courseName"];
    }
    return "";
  }
  String returncode(String value,int index){
    switch(value){
      case "School":return accinfo.recommendedlist[index];
      case 'Cut-Off':return accinfo.recommendedlistcutoff[index];
      case 'Alphabet':return accinfo.recommendedlistalphabet[index];
      case 'Location':return accinfo.recommendedlist[index];
    }
    return "";
  }

  int returnlist(String value){
    switch(value){
      case "School":return accinfo.recommendedlist.length;
      case 'Cut-Off':return accinfo.recommendedlistcutoff.length;
      case 'Alphabet':return accinfo.recommendedlistalphabet.length;
      case 'Location':return accinfo.recommendedlist.length;
    }
    return 0;
  }

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
                  itemCount: returnlist(filtervalue),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ListTile(

                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => selected(returncode(filtervalue, index))));
                          },
                          leading: Image.asset('assets/images/${returncode(filtervalue, index)[0]}.jpg'),
                          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                          tileColor: Colors.grey[70],
                          //shape: RoundedRectangleBorder(
                              //borderRadius: BorderRadius.circular(18.0),
                             // side: BorderSide(color: Colors.red,width: 3)
                         // )
                          //,
                          title: Text("School: ${returnschool(filtervalue, index)} \nCourse: ${returncourse(filtervalue, index)}\nCut-off:${returncutoff(filtervalue, index)}")),
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
