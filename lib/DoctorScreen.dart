import 'dart:ui';

import 'package:flutter/material.dart';
class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
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
    child: Container()
    ),
    ),
    )
    ],
    ),);
  }
}
