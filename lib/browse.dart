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
  String filtervalue ='School';
  Future<List<Widget>> search(String? search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search!.length, (int index) {
      return Center(child: Text("no result"));
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => selected(accinfo.allcourse.keys.elementAt(index))));
                          },
                            title: Text("School: ${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["school_name"]} \nCourse: ${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseName"]}\nCut-off:${accinfo.allcourse[accinfo.allcourse.keys.elementAt(index)]["courseCutOff"]}"),
                          leading: Image.asset('assets/images/${accinfo.allcourse.keys.elementAt(index)[0]}.jpg'),
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
                items: <String>['School', 'Cut-Off', 'Alphabet', 'Location']
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
