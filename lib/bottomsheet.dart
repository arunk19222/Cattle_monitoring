import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/individual_info.dart';

Widget bottomsheet(dynamic context, AnimationController animate_controller,
    Map<String, dynamic>? map) {
  Color indication_color;
  dynamic datas = map;
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
  ]).animate(animate_controller);
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
  ]).animate(animate_controller);
  if ((datas['temp'] < 200 && datas['temp'] >= 120) ||
      (datas['blood_pressure'] < 200 && datas['blood_pressure'] >= 181) ||
      (datas['heart_beat'] < 130 && datas['heart_beat'] >= 70) ||
      (datas['respiration_rate'] < 210 && datas['respiration_rate'] >= 60) ||
      (datas['injury'] != null)) {
    indication_color = Color(0xffA31805);
  } else if (datas['location'] > 300) {
    indication_color = Color(0xffE1DE09);
  } else if ((datas['temp'] < 120 && datas['temp'] >= 70) ||
      (datas['blood_pressure'] < 181 && datas['blood_pressure'] >= 165) ||
      (datas['heart_beat'] < 70 && datas['heart_beat'] >= 45) ||
      (datas['respiration_rate'] < 60 && datas['respiration_rate'] >= 40)) {
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
                animation: animate_controller,
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
              child: Center(child: individual_info(datas, indication_color)),
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
              animation: animate_controller,
              builder: (BuildContext context, Widget? child) {
                return CircleAvatar(
                  radius: 55,
                  backgroundColor: indication_color,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/cow_symbol.png')),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
