import 'package:flutter/material.dart';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart';
import 'package:my_next_step/accinfo.dart';
import './selectedcourse.dart';

class browse extends StatefulWidget {
  const browse({Key? key}) : super(key: key);

  @override
  _browseState createState() => _browseState();
}

class _browseState extends State<browse> {
  
  String returnschool(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["school_name"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.cutofflist[index]]["school_name"];
      case 'Alphabet':return accinfo.allcourse[accinfo.alphabetlist[index]]["school_name"];

    }
    return "";
  }
  String returncutoff(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseCutOff"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.cutofflist[index]]["courseCutOff"];
      case 'Alphabet':return accinfo.allcourse[accinfo.alphabetlist[index]]["courseCutOff"];

    }
    return "";
  }

  String returncourse(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseName"];
      case 'Cut-Off':return accinfo.allcourse[accinfo.cutofflist[index]]["courseName"];
      case 'Alphabet':return accinfo.allcourse[accinfo.alphabetlist[index]]["courseName"];

    }
    return "";
  }
  String returncode(String value,int index){
    switch(value){
      case "School":return accinfo.allcourse.keys.elementAt(index);
      case 'Cut-Off':return accinfo.cutofflist[index];
      case 'Alphabet':return accinfo.alphabetlist[index];

    }
    return "";
  }

  List<String> searchresult=[];
  
  String filtervalue ='School';
  Future<List<Widget>> search(String? search) async {
    await Future.delayed(Duration(seconds: 2));
    searchresult = [];
    for(int i=0;i<accinfo.allcourse.length;i++){
      if(accinfo.allcourse[accinfo.allcourse.keys.elementAt(i)]["courseName"].toLowerCase().contains(search?.toLowerCase()))
        searchresult.add(accinfo.allcourse.keys.elementAt(i));
    }
    return List.generate(searchresult.length, (int index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => selected(searchresult[index])));
          },
          title: Text("School: ${accinfo.allcourse[searchresult[index]]["school_name"]} \nCourse: ${accinfo.allcourse[searchresult[index]]["courseName"]}\nCut-off:${accinfo.allcourse[searchresult[index]]["courseCutOff"]}"),
          leading: Image.asset('assets/images/${searchresult[index][0]}.jpg'),
          shape: RoundedRectangleBorder(

            // side: BorderSide(color: Colors.red,width: 3)  have to figure out how to implement border color
          )
          ,
          tileColor: Colors.white,
          trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        child: SafeArea(
          child: Stack(
              children: [

            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leadingWidth: 100,
                automaticallyImplyLeading: true,
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                leading: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.black,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 40,
                    ),
                    Text("Back",style: TextStyle(color: Colors.black),)
                  ],
                ),

              ),
              body: SearchBar<Widget>(

                placeHolder: ListView.separated(
                    itemCount: accinfo.allcourse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => selected(returncode(filtervalue, index))));
                          },
                            title: Text("School: ${returnschool(filtervalue, index)} \nCourse: ${returncourse(filtervalue, index)}\nCut-off:${returncutoff(filtervalue, index)}"),
                          leading: Image.asset('assets/images/${returncode(filtervalue, index)[0]}.jpg'),
                          shape: RoundedRectangleBorder(

                             // side: BorderSide(color: Colors.red,width: 3)  have to figure out how to implement border color
                          )
                          ,
                            tileColor: Colors.white,
                            trailing: Icon(Icons.arrow_forward_outlined,color: Colors.black,),),
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
              },),
                onSearch: search,
                onItemFound: (Widget? tile, int index) {
                  return tile!;
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width * 0.95,
              alignment: Alignment.topRight,
              child: DropdownButton<String>(
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
                items: <String>['School', 'Cut-Off', 'Alphabet']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

          ]),
        ),
      ),
    );
  }
}
