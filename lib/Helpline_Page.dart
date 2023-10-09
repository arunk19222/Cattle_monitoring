import 'package:flutter/material.dart';

class helpline_page extends StatefulWidget {
  const helpline_page({Key? key}) : super(key: key);

  @override
  State<helpline_page> createState() => _helpline_pageState();
}

class _helpline_pageState extends State<helpline_page> {
  bool profile_touch = false;
  int index_temp= 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 300,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(30))),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: (){
                            setState(() {
                              profile_touch = true;
                              index_temp = index;
                            });
                          },
                          onTap: (){
                            setState(() {
                              profile_touch = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      color: Colors.black87)
                                ],
                                border: Border.all(color: Colors.black87, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(120))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: CircleAvatar(
                                radius:40,
                                backgroundImage: NetworkImage("https://t4.ftcdn.net/jpg/03/20/52/31/360_F_320523164_tx7Rdd7I2XDTvvKfz2oRuRpKOPE5z0ni.jpg"),
                              )
                            ),
                          ),
                        ),
                        (profile_touch && index == index_temp)?Padding(
                          padding: const EdgeInsets.only(left:20),
                          child: Icon(Icons.call,color: Colors.green,size:30,)
                        ):Container(width:0,height:0,)
                      ],
                    ),
                    Text("Doctor ${index + 1}",style: TextStyle(fontSize: 20,
                        fontFamily: 'Rajdhani-Regular',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    Row(
                      children: [Icon(Icons.location_pin,color: Colors.red,size:30,),Expanded(
                        child: Text("144,Erukanchery,High Road,Sharma Nagar,Vysarpadi,Chennai,Tamil nadu-600039",style: TextStyle(fontSize: 20,
                            fontFamily: 'Rajdhani-Regular',
                            letterSpacing:1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      ),],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Review:4/5",style: TextStyle(fontSize: 20,
                        fontFamily: 'Rajdhani-Regular',
                        letterSpacing:2,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),Icon(Icons.star,color: Colors.yellow,)],

                    )
                  ],
                ),
              ),
            ),
          );
        },
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
