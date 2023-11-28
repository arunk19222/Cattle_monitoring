import 'package:flutter/material.dart';
class prescription_class extends StatefulWidget {
  const prescription_class({super.key});

  @override
  State<prescription_class> createState() => _prescription_classState();
}

class _prescription_classState extends State<prescription_class> with SingleTickerProviderStateMixin{
  late AnimationController animationController ;
  late Animation<double>  animation;
  @override
  Widget build(BuildContext context) {
    animationController = AnimationController(vsync: this,duration: Duration(seconds:2))..repeat(reverse:true);
    Tween<double> _tween = Tween(begin: 0.5, end: 1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:10,top:5),
          child: ScaleTransition(scale: _tween.animate(CurvedAnimation(parent:animationController, curve:Curves.ease)),child: Container(child:Icon(Icons.medical_services,color: Colors.white,size:50,),)),
        ),
        Text("• Ivexin Oral Solution 2mL",style: TextStyle(
            fontFamily: 'Rajdhani-Regular',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900),),
        Text("• Dimi-Cough 20mL",style: TextStyle(
            fontFamily: 'Rajdhani-Regular',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900),),
        Text("• RIVLIV tonic 50mL twice",style: TextStyle(
            fontFamily: 'Rajdhani-Regular',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900),),
        Text("• 23% calciumgluconate IV",style: TextStyle(
            fontFamily: 'Rajdhani-Regular',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900),),
      ],
    );
  }
}
