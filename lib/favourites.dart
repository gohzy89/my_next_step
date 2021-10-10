import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './accinfo.dart';
import './selectedcourse.dart';
import 'dart:convert';

class favourite extends StatefulWidget {
  const favourite({Key? key}) : super(key: key);

  @override
  _favouriteState createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {

  Widget flist(BuildContext context,ScrollController scrollController){
    if(accinfo.favlist.length!=0)
    return ListView.separated(
      controller: scrollController,
      itemCount: accinfo.favlist.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            onTap: () {
              accinfo.fromfav =true;
              Navigator.push(context, MaterialPageRoute(builder: (context) => selected(accinfo.favlist[index])));
            },
            leading: IconButton(icon:Icon(Icons.highlight_remove),onPressed: (){
              accinfo.favlist.removeAt(accinfo.favlist.indexOf(accinfo.favlist[index]));
              setState(() {

              });
            },),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
            tileColor: Colors.grey[70],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red,width: 3)
            )
            ,
            title: Text(accinfo.allcourse[accinfo.favlist[index]]["courseName"]));
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
    else
      return Center(child: Text("No favourites"),);

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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("Favourite",style: TextStyle(fontSize: 25,color: Colors.black),),
            ),
          ),

          SizedBox.expand(
            child: DraggableScrollableSheet(
              maxChildSize: 0.9,
              minChildSize: 0.9,
              initialChildSize: 0.9,
              builder: (BuildContext context, ScrollController scrollController) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: flist(context,scrollController),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
