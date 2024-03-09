import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/firebase_actions.dart';
class prescription_class extends StatefulWidget {
  const prescription_class({super.key,required this.datas});
  final Map<String, dynamic>? datas;
  @override
  State<prescription_class> createState() => _prescription_classState();
}

class _prescription_classState extends State<prescription_class>{
  var text_controller  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white
            ),
            child: TextFormField(
              maxLines: null,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rajdhani-Regular',
                    fontSize: 17,
                    color:Colors.black ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Help And Support",
              ),
              controller: text_controller,
            ),
          ),
          ElevatedButton(onPressed: () {
            post_comments(string:text_controller.text,datas:widget.datas);
          }, child: Text("POST"))
        ],
      ),
    );
  }
}
