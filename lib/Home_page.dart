import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/Display_Filter_List.dart';
import 'package:flutter_veltech_project/Health_page.dart';
import 'package:flutter_veltech_project/Helpline_Page.dart';
import 'package:flutter_veltech_project/Location_page.dart';
import 'package:flutter_veltech_project/bottomsheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class graph_data{
  final x;
  final y;
  graph_data({required this.x,required this.y}){
  }

}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TextEditingController search_controller = TextEditingController();
  var temp_f = false, blood_f = false, heart_f = false, air_f = false;
  late AnimationController _animationController;
  Map<String, dynamic>? cloud_datas;
  late Widget current_scaffold_body_widget;
  int index = 0;
  late bool is_graph ;
  late ChartSeriesController? _chartSeriesController;
  List<graph_data> datas = [
    graph_data(x: 1, y: 10),
    graph_data(x: 2, y: 20),
    graph_data(x: 3, y: 30),
    graph_data(x: 4, y: 30),
    graph_data(x: 5, y: 50),
    graph_data(x: 7, y: 0),
  ];

  @override
  void initState() {
    is_graph= true;
    search_controller.text = "";
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.repeat();
    current_scaffold_body_widget = Container();
  }

  Future<dynamic> get_cow_data() async {
    var collection = FirebaseFirestore.instance.collection('temp');
    var docSnapshot = await collection
        .doc(search_controller.text)
        .get(); //use  null check operator after
    //firebase.instance.something!
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      cloud_datas = data;
      cloud_datas!['id'] = search_controller.text;
      // Call setState if needed.
    }
    return Future.delayed(Duration(seconds: 1), () {
      return cloud_datas;
    });
  }

  dynamic rest_containers = Container(
    height: 500,
  );
  void filter_temp(var value) {
    if (value) {
      setState(() {
        search_controller.text = "";
        heart_f = false;
        blood_f = false;
        air_f = false;
        rest_containers = Expanded(
          child: display_filter_list(
            context: context,
            filter_type: "temp",
            animation_controller: _animationController,
          ),
        );
      });
    }
    setState(() {
      temp_f = value;
    });
  }

  void filter_blood(var value) {
    if (value) {
      setState(() {
        search_controller.text = "";
        temp_f = false;
        heart_f = false;
        air_f = false;
        rest_containers = Expanded(
            child: display_filter_list(
          context: context,
          filter_type: "blood_pressure",
          animation_controller: _animationController,
        ));
      });
    }

    setState(() {
      blood_f = value;
    });
  }

  void filter_air(var value) {
    if (value) {
      setState(() {
        search_controller.text = "";
        temp_f = false;
        heart_f = false;
        blood_f = false;
        rest_containers = Expanded(
            child: display_filter_list(
          context: context,
          filter_type: "respiration_rate",
          animation_controller: _animationController,
        ));
      });
    }
    setState(() {
      air_f = value;
    });
  }

  void filter_heart(var value) {
    if (value) {
      setState(() {
        search_controller.text = "";
        blood_f = false;
        temp_f = false;
        air_f = false;
        rest_containers = Expanded(
            child: display_filter_list(
          context: context,
          filter_type: "heart_beat",
          animation_controller: _animationController,
        ));
      });
    }
    setState(() {
      heart_f = value;
    });
  }

  Widget Home_Screen() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: search_controller,
              onSubmitted: (string) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return FutureBuilder(
                        builder: (context, snap) {
                          return bottom_sheet_class(context: context, animate_controller: _animationController, map: snap.data);
                        },
                        future: get_cow_data(),
                      );
                      //invoke firebase cloud to get pariticular cow value from where we typed in search box
                      //bottomsheet.dart file
                    });
              },
              decoration: InputDecoration(
                  hintText: "ID/Name",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width:1)
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width:0.5)
                  )),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.thermostat_outlined,size: 30,),
                CupertinoSwitch(
                  value: temp_f,
                  onChanged: filter_temp,
                  activeColor: Colors.black,
                  trackColor: Colors.black38,
                  thumbColor: Colors.deepOrange,
                ),
                Icon(Icons.bloodtype,size:30,),
                CupertinoSwitch(
                  value: blood_f,
                  onChanged: filter_blood,
                  activeColor: Colors.black,
                  trackColor: Colors.black38,
                  thumbColor: Color.fromRGBO(255, 0, 0, 2.0),
                ),
                Icon(Icons.monitor_heart,size:30,),
                CupertinoSwitch(
                  value: heart_f,
                  onChanged: filter_heart,
                  activeColor: Colors.black,
                  trackColor: Colors.black38,
                  thumbColor: Colors.pink,
                ),
                Icon(Icons.air,size:30,),
                CupertinoSwitch(
                    value: air_f,
                    onChanged: filter_air,
                    activeColor: Colors.black,
                    trackColor: Colors.black38,
                    thumbColor: Colors.white
                ),
              ],
            ),
          ),
          (temp_f || blood_f || heart_f || air_f)
              ? rest_containers
              : Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(left:5,right:5,bottom:5),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        width:500,
                        height:600,
                        child: Stack(
                          children: [is_graph?SfCartesianChart(
                            borderColor: Colors.transparent,
                            borderWidth: 0,
                            zoomPanBehavior: ZoomPanBehavior(enablePinching: true,maximumZoomLevel:0.6,enableDoubleTapZooming: true,enablePanning:true),
                            plotAreaBorderWidth:0,
                            tooltipBehavior: TooltipBehavior(enable: true),
                            primaryXAxis: CategoryAxis(
                                labelStyle:TextStyle(color: Colors.white70),

                                isVisible: true, majorGridLines: MajorGridLines(width:0),minimum:0,
                                borderWidth: 0,
                                interval: 1
                            ),
                            primaryYAxis: CategoryAxis(
                              title: AxisTitle(text: "Litres/Week",textStyle: TextStyle(
                                  color: Colors.white,letterSpacing: 1
                              )),
                              labelStyle:TextStyle(color: Colors.white70),
                              majorGridLines: MajorGridLines(width:0),
                              minimum:0,
                              maximum: 80,
                              isVisible: true,
                              interval: 5,
                            ),
                            legend: Legend(isVisible: true,backgroundColor: Colors.white,textStyle: TextStyle(color: Colors.black,fontSize:20)),
                            series: <ChartSeries<graph_data,int>>[

                              SplineAreaSeries(markerSettings: MarkerSettings(
                                  isVisible: true,
                                  color: Colors.black,
                                  borderWidth:0.5,
                                  shape: DataMarkerType.circle,
                                  borderColor: Colors.white70),onRendererCreated: (ChartSeriesController? controller){
                                _chartSeriesController = controller;
                                Future.delayed(Duration(seconds:0),(){
                                  _chartSeriesController?.animate();
                                });
                              }
                                  ,animationDuration:3000,name:"Milk Productions",dataSource: datas, xValueMapper:(graph_data data,_)=>data.x, yValueMapper: (graph_data data,_)=>data.y,
                                  gradient:LinearGradient(colors: [Color(0xff383741),Color(0xff837b7b),Color(0xffc4d3d6)],begin:Alignment.bottomLeft,end: Alignment.bottomRight)),

                            ],
                          ):Container(),
                            GestureDetector(
                              onTap: (){
                                if(is_graph){
                                  setState(() {
                                    is_graph=false;
                                  });
                                }else{
                                  setState(() {
                                    is_graph=true;
                                  });
                                }
                              },
                              child:Padding(
                                padding: const EdgeInsets.only(top:15,right: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width:40,height:40,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                      boxShadow: [BoxShadow(color: Colors.white,spreadRadius:1,blurRadius:2,offset:Offset(0,2))]
                                    ),
                                      child: Icon(is_graph?Icons.pie_chart:Icons.area_chart,size:40,color: Colors.white,)),
                                ),
                              ),
                            )],
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget Health_Screen() {
    return health_page();
  }

  Widget Location_Screen() {
    return location_page();
  }

  Widget HelpLine_Screen() {
    return helpline_page();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                  child: getselected_body(index),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.black,
          height: 50,
          index: index,
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(Icons.local_hospital, color: Colors.white),
            Icon(Icons.location_off, color: Colors.white),
            Icon(Icons.call, color: Colors.white)
          ],
          onTap: (i) {
            setState(() {
              index = i;
            });
          },
        ),
      ),
    );
  }

  Widget getselected_body(int index) {
    switch (index) {
      case 0:
        current_scaffold_body_widget = Home_Screen();
        break;
      case 1:
        current_scaffold_body_widget = Health_Screen();

        break;
      case 2:
        current_scaffold_body_widget = Location_Screen();
        break;
      case 3:
        current_scaffold_body_widget = HelpLine_Screen();
        break;
    }
    return current_scaffold_body_widget;
  }
}
