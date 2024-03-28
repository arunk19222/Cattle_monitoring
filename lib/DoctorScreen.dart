import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}
class _doctorState extends State<doctor> {
  
  Widget ListOfChats(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Queries").snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
      if(snapshot.hasData){
        var datas = snapshot.requireData;
        return ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){


              },
              child: Container(
                  height:50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),child: Text(datas.docs[index]["name"].toString())),
            ),
          );
        },itemCount:datas.size,);
      }else{
        return Center(child: Container(child: Text("No Messages"),),);
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
        Container(decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/background.jpg'),
    fit: BoxFit.cover
    )
    ),),
    ClipRect(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX:3,sigmaY:3),
    child: Padding(
    padding: const EdgeInsets.only(top:20),
    child: ListOfChats()
    ),
    ),
    )
    ],
    ),);
  }
}
