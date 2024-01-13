import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/individual_info.dart';
import 'package:flutter_veltech_project/prescriptions.dart';
class bottom_sheet_class extends StatefulWidget {
  final dynamic context; final AnimationController animate_controller;
  final Map<String, dynamic>? map;
  const bottom_sheet_class(
      {Key? key,
        required this.context,
        required this.animate_controller,
        required this.map})
      : super(key: key);

  @override
  State<bottom_sheet_class> createState() => _bottom_sheet_classState();
}

class _bottom_sheet_classState extends State<bottom_sheet_class> {
  late Color indication_color;
  late dynamic datas ;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    datas = widget.map;
    if (datas == null) {
      datas = {
        'temp': 0,
        'blood_pressure': 0,
        'id': "cow",
        'location': 0,
        'respiration_rate': 0,
        'heart_beat': 0
      };
    }
    Animation<Alignment> _topalignment = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween:
          Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
    ]).animate(widget.animate_controller);
    Animation<Alignment> _bottomalignment = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomRight, end: Alignment.bottomLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.bottomLeft, end: Alignment.topLeft),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween:
          Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.topRight),
          weight: 1),
      TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
              begin: Alignment.topRight, end: Alignment.bottomRight),
          weight: 1),
    ]).animate(widget.animate_controller);
    if ((datas['temp'] >= 55) ||
        (datas['blood_pressure'] >= 40) ||
        (datas['heart_beat'] >= 35) ||
        (datas['respiration_rate'] >= 60) ||
        (datas['injury'] != null)) {
      indication_color = Color(0xffA31805);
    } else if (datas['location'] > 300) {
      indication_color = Color(0xffE1DE09);
    } else if ((datas['temp'] < 55 && datas['temp'] >=30) ||
        (datas['blood_pressure'] < 40 && datas['blood_pressure'] >= 20) ||
        (datas['heart_beat'] < 35 && datas['heart_beat'] >= 25) ||
        (datas['respiration_rate'] < 60 && datas['respiration_rate'] >= 30)) {
      indication_color = Color(0xffED8715);
    } else {
      indication_color = Color(0xff009e78);
    }
    return BackdropFilter(
      filter: ImageFilter.blur(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 40,
              child: AnimatedBuilder(
                  animation: widget.animate_controller,
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 1.24,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                blurRadius: 30,
                                spreadRadius: 10)
                          ],
                          gradient: LinearGradient(
                              colors: [Color(0xff191919), indication_color],
                              begin: _topalignment.value,
                              end: _bottomalignment.value),
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    );
                  }),
            ),
            Positioned(
              top: 45,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.2,
                child: Center(child: flag?individual_info(datas, indication_color):prescription_class()),
                decoration: BoxDecoration(
                    color: Color(0xff1e1f1d), //Color(0xffC0C0C0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
              ),
            ),
            Positioned(
              top: 0,
              child: AnimatedBuilder(
                animation: widget.animate_controller,
                builder: (BuildContext context, Widget? child) {
                  return GestureDetector(
                    onTap:(){
                      setState(() {
                        if(flag){
                          flag = false;
                        }else{
                          flag = true;
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: indication_color,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                          AssetImage('assets/images/cow_symbol.png')),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

