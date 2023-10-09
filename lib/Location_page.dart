import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bottomsheet.dart';

class location_page extends StatefulWidget {
  const location_page({Key? key}) : super(key: key);

  @override
  State<location_page> createState() => _location_pageState();
}

class _location_pageState extends State<location_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Map<String, dynamic>? cloud_datas;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<dynamic> get_cow_data(String id) async {
    var collection = FirebaseFirestore.instance.collection('temp');
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('temp')
            .orderBy('location', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("waiting");
          } else {
            return ListView.builder(
              itemCount: snapshot.requireData.size,
              itemBuilder: (BuildContext context, int index) {
                try {
                  var data = snapshot.requireData.docs[index].get('location');
                  if (data > 300) {
                    return ListTile(
                      leading: Icon(Icons.pets),
                      title: Text(
                        "${snapshot.requireData.docs[index].id}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Rajdhani-Regular'),
                      ),
                      subtitle: Text("Outlier : ${data - 300}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Rajdhani-Regular')),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                builder: (context, snap) {
                                  return bottomsheet(
                                      context, _animationController, snap.data);
                                },
                                future: get_cow_data(
                                    snapshot.requireData.docs[index].id),
                              );
                            });
                      },
                      iconColor: Colors.brown,
                    );
                  }
                } catch (e) {}
                return Container();
              },
              physics: BouncingScrollPhysics(),
            );
          }
        });
  }
}
