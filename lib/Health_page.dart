import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/bottomsheet.dart';

class health_page extends StatefulWidget {
  const health_page({Key? key}) : super(key: key);

  @override
  State<health_page> createState() => _health_pageState();
}

class _health_pageState extends State<health_page>
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
        stream: FirebaseFirestore.instance.collection('temp').snapshots(),
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
                  var data = snapshot.requireData.docs[index].get('injury');
                  if (data != null) {
                    return ListTile(
                      leading: Icon(Icons.pets),
                      title: Text(
                        "${snapshot.requireData.docs[index].id}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            fontFamily: 'Rajdhani-Regular'),
                      ),
                      subtitle: Text("Injury  : ${data}",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              fontFamily: 'Rajdhani-Regular')),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                builder: (context, snap) {
                                  return bottom_sheet_class(context: context, animate_controller: _animationController, map: snap.data);
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
