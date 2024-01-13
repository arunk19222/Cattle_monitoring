import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/bottomsheet.dart';

class display_filter_list extends StatefulWidget {
  final String filter_type;
  final dynamic context;
  final animation_controller;
  const display_filter_list(
      {Key? key,
      required this.filter_type,
      required this.context,
      required this.animation_controller})
      : super(key: key);

  @override
  State<display_filter_list> createState() => _display_filter_listState();
}

class _display_filter_listState extends State<display_filter_list>
    with SingleTickerProviderStateMixin {
  late Stream<QuerySnapshot> temp;
  late Color font_color;
  double slider_start_value = 10, slider_end_value = 210;
  Map<String, dynamic>? cloud_datas;
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat();
    temp = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .orderBy(widget.filter_type, descending: true)
        .snapshots();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<dynamic> get_cow_data(String id) async {
    var collection = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
    var docSnapshot =
        await collection.doc(id).get(); //use  null check operator after
    //firebase.instance.something!
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      cloud_datas = data;
      cloud_datas!['id'] = id;
      // Call setState if needed.
    }
    return Future.delayed(Duration(seconds: 1), () {
      return cloud_datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Column(
        children: [
          Container(
            child: Card(
              color: Colors.white.withOpacity(0.1),
              elevation: 10,
              child: SliderTheme(
                data: SliderTheme.of(context)
                    .copyWith(showValueIndicator: ShowValueIndicator.always),
                child: RangeSlider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.black38,
                    values: RangeValues(slider_start_value, slider_end_value),
                    labels: RangeLabels(slider_start_value.round().toString(),
                        slider_end_value.round().toString()),
                    onChanged: (v) {
                      setState(() {
                        slider_start_value = v.start;
                        slider_end_value = v.end;
                      });
                    },
                    min: 10,
                    max: 210),
              ),
            ),
          ),
          Expanded(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white.withOpacity(0.2),
              body: StreamBuilder<QuerySnapshot>(
                  stream: temp,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("err");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: Text("Waiting"));
                    } else {
                      if (widget.filter_type == 'temp') {
                        font_color = Colors.deepOrangeAccent;
                      } else if (widget.filter_type == 'blood_pressure') {
                        font_color = Colors.red;
                      } else if (widget.filter_type == 'respiration_rate') {
                        font_color = Colors.black;
                      } else {
                        font_color = Colors.pink;
                      }
                      final data = snapshot.requireData;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var value = data.docs[index][widget.filter_type];
                          if (value >= slider_start_value &&
                              value <= slider_end_value) {
                            return Card(
                              color: Colors.white.withOpacity(0.3),
                              child: ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return FutureBuilder(
                                          builder: (context, snap) {
                                            return bottom_sheet_class(context: context, animate_controller: _animationController, map: snap.data);
                                          },
                                          future:
                                              get_cow_data(data.docs[index].id),
                                        );
                                      });
                                },
                                leading: Chip(
                                  backgroundColor: Colors.black87,
                                  elevation: 16,
                                  labelPadding:
                                      EdgeInsets.only(left: 10, right: 10),
                                  shadowColor: Colors.brown,
                                  label: Text(
                                    '${data.docs[index].id}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Rajdhani-Regular',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                trailing: Text(
                                  '${data.docs[index][widget.filter_type]}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Rajdhani-Regular',
                                      fontSize: 19,
                                      color: font_color),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                        itemCount: data.size,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
