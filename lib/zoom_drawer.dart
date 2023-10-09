import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/Home_page.dart';
import 'package:flutter_veltech_project/LoginPage.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class zoomable_drawer extends StatefulWidget {
  const zoomable_drawer({Key? key}) : super(key: key);

  @override
  State<zoomable_drawer> createState() => _zoomable_drawerState();
}

class _zoomable_drawerState extends State<zoomable_drawer> {
  var tot_c, ab_c, mod_c, hlt_c, out_c;

  summa() async {
    var data_ref = FirebaseFirestore.instance.collection('temp');
    await data_ref.get().then((value) {
      value.docs.forEach((datas) {
        if (datas.get('location') > 300) {
          out_c += 1;
        }
        if ((datas['temp'] < 200 && datas['temp'] >= 120) ||
            (datas['blood_pressure'] < 200 && datas['blood_pressure'] >= 181) ||
            (datas['heart_beat'] < 130 && datas['heart_beat'] >= 70) ||
            (datas['respiration_rate'] < 210 &&
                datas['respiration_rate'] >= 60)) {
          ab_c += 1;
        } else if ((datas['temp'] < 120 && datas['temp'] >= 70) ||
            (datas['blood_pressure'] < 181 && datas['blood_pressure'] >= 165) ||
            (datas['heart_beat'] < 70 && datas['heart_beat'] >= 45) ||
            (datas['respiration_rate'] < 60 &&
                datas['respiration_rate'] >= 40)) {
          mod_c += 1;
        } else {
          hlt_c += 1;
        }
      });
    });
    setState(() {
      tot_c = mod_c + ab_c + hlt_c;
    });
  }

  Widget Drawer_screen(var context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
          boxShadow: [
            BoxShadow(color: Colors.black54, spreadRadius: 20, blurRadius: 20)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 200,
                child: Container(
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            spreadRadius: 5,
                            blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Vel Murugan",
                      style: TextStyle(
                          fontFamily: 'Rajdhani-Regular',
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red,
                      ),
                      Container(
                        child: Text(
                          "Chennai",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Container(
            color: Colors.white,
            child: Divider(
              height: 4,
              thickness: 5,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 25),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Total Cows   ",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          tot_c.toString(),
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Abnormal Cows  ",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xffFF012C),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          ab_c.toString(),
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xffFF012C),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Moderate Cows   ",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.deepOrangeAccent,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          mod_c.toString(),
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.deepOrangeAccent,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Healthy Cows   ",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xff009e78),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          hlt_c.toString(),
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xff009e78),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  Outlier Cows   ",
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xffE1DE09),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          out_c.toString(),
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Color(0xffE1DE09),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 1,
            color: Colors.black54,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: SizedBox(
              width: 80,
              height: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    shadowColor: Colors.blueGrey,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)))),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Login_page()));
                },
                child: Icon(
                  Icons.exit_to_app_sharp,
                  size: 40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill
          )),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ZoomDrawer(
          angle: 0,
          borderRadius: 50,
          shadowLayer2Color: Colors.white.withOpacity(0.5),
          shadowLayer1Color: Colors.black54.withOpacity(0.4),
          mainScreenTapClose: true,
          showShadow: true,
          boxShadow: [
            BoxShadow(color: Colors.black54, spreadRadius: 20, blurRadius: 20)
          ],
          menuScreenWidth: 270,
          overlayBlur: 2,
          mainScreen: Home(),
          menuScreen: Drawer_screen(context),
          isRtl: true,
        ),
      ),
    );
  }

  @override
  void initState() {
    tot_c = ab_c = mod_c = hlt_c = out_c = 0;
    summa();
  }
}
