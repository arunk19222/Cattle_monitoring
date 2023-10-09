import 'package:flutter/material.dart';

Widget individual_info(Map<String, dynamic>? datas, Color shadow_color) {
  return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chip(
                elevation: 10,
                shadowColor: shadow_color,
                label: Text(
                  datas!['id'],
                  style: TextStyle(
                      fontFamily: 'Rajdhani-Regular',
                      color: Colors.black54,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Temperature",
                style: TextStyle(
                    fontFamily: 'Rajdhani-Regular',
                    color: Colors.white,
                    fontSize: 28),
              ),
              Row(
                children: [
                  Text(
                    datas!['temp'].toString(),
                    style: TextStyle(
                        fontFamily: 'Rajdhani-Regular',
                        color: Colors.deepOrangeAccent,
                        fontSize: 28),
                  ),
                  Icon(
                    Icons.thermostat_outlined,
                    color: Colors.deepOrangeAccent.withOpacity(0.5),
                    size: 20,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Blood Pressure",
                style: TextStyle(
                    fontFamily: 'Rajdhani-Regular',
                    color: Colors.white,
                    fontSize: 28),
              ),
              Row(
                children: [
                  Text(
                    datas!['blood_pressure'].toString(),
                    style: TextStyle(
                        fontFamily: 'Rajdhani-Regular',
                        color: Color(0xffFF012C),
                        fontSize: 28),
                  ),
                  Icon(
                    Icons.bloodtype,
                    color: Color(0xffFF012C).withOpacity(0.5),
                    size: 20,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Heart Rate",
                style: TextStyle(
                    fontFamily: 'Rajdhani-Regular',
                    color: Colors.white,
                    fontSize: 28),
              ),
              Row(
                children: [
                  Text(
                    datas!['heart_beat'].toString(),
                    style: TextStyle(
                        fontFamily: 'Rajdhani-Regular',
                        color: Colors.pink,
                        fontSize: 28),
                  ),
                  Icon(
                    Icons.monitor_heart,
                    color: Colors.pink.withOpacity(0.5),
                    size: 20,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Respiration Rate",
                style: TextStyle(
                    fontFamily: 'Rajdhani-Regular',
                    color: Colors.white,
                    fontSize: 28),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        datas!['respiration_rate'].toString(),
                        style: TextStyle(
                            fontFamily: 'Rajdhani-Regular',
                            color: Colors.white,
                            fontSize: 28),
                      ),
                      Icon(
                        Icons.air,
                        size: 20,
                        color: Colors.white.withOpacity(0.5),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location",
                style: TextStyle(
                    fontFamily: 'Rajdhani-Regular',
                    color: Colors.white,
                    fontSize: 28),
              ),
              Row(
                children: [
                  Text(
                    datas!['location'] > 300
                        ? (datas!['location'] - 300).toString()
                        : '0',
                    style: TextStyle(
                        fontFamily: 'Rajdhani-Regular',
                        color: Color(0xffE1DE09),
                        fontSize: 28),
                  ),
                  Icon(
                    Icons.location_off,
                    size: 20,
                    color: Color(0xffE1DE09).withOpacity(0.5),
                  )
                ],
              ),
            ],
          ),
          datas!['injury'] != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Injury",
                      style: TextStyle(
                          fontFamily: 'Rajdhani-Regular',
                          color: Colors.white,
                          fontSize: 28),
                    ),
                    Row(
                      children: [
                        Text(
                          datas!['injury'],
                          style: TextStyle(
                              fontFamily: 'Rajdhani-Regular',
                              color: Colors.redAccent,
                              fontSize: 28),
                        ),
                        Icon(
                          Icons.warning,
                          size: 20,
                          color: Colors.redAccent.withOpacity(0.5),
                        )
                      ],
                    ),
                  ],
                )
              : Container()
        ],
      ));
}
