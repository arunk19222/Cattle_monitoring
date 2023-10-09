import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/zoom_drawer.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  PageController pageController = PageController();
  TextEditingController s_email = TextEditingController();
  TextEditingController s_pass = TextEditingController();
  TextEditingController s_repass = TextEditingController();
  TextEditingController l_email = TextEditingController();
  TextEditingController l_pass = TextEditingController();
  var issign_in_page = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
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
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            spreadRadius: 10,blurRadius:10,color: Colors.black54
                        )],
                        color: Colors.black.withOpacity(0.4),
                        borderRadius:BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(0);
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(fontSize: 24, color: issign_in_page?Colors.white:Colors.grey),
                                    ),
                                  ),
                                  VerticalDivider(color: Colors.white,thickness:2),
                                  GestureDetector(
                                      onTap: () {
                                        pageController.jumpToPage(1);
                                      },
                                      child: Text("Login",
                                          style:
                                          TextStyle(fontSize: 24, color: issign_in_page?Colors.grey:Colors.white))
                                  )
                                ],
                              ),
                            ),
                            Divider(color: Colors.white,thickness:1.4,height:40),
                            Expanded(
                              child: PageView(
                                controller: pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    issign_in_page = index == 0 ? true : false;
                                  });
                                },
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextField(
                                            controller: s_email,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10))),
                                                hintText: "Mail",
                                                prefixIcon: IconTheme(
                                                  data: IconThemeData(color: Colors.black87),
                                                  child: Icon(Icons.mail),
                                                )),
                                          ),
                                          TextField(
                                            controller: s_pass,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10))),
                                                hintText: "Password",
                                                prefixIcon: IconTheme(
                                                  data: IconThemeData(color: Colors.black87),
                                                  child: Icon(Icons.password_outlined),
                                                )),
                                          ),
                                          TextField(
                                            controller: s_repass,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10))),
                                                hintText: "Retype Password",
                                                prefixIcon: IconTheme(
                                                  data: IconThemeData(color: Colors.black87),
                                                  child: Icon(Icons.password_outlined),
                                                )),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.black,
                                                        shadowColor: Colors.blueGrey,

                                                        elevation: 12,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(60)))),
                                                    onPressed: () {
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  zoomable_drawer()));
                                                    },
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 32,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextField(
                                            controller: l_email,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10))),
                                                hintText: "Mail",
                                                prefixIcon: IconTheme(
                                                  data: IconThemeData(color: Colors.black87),
                                                  child: Icon(Icons.mail),
                                                )),
                                          ),
                                          TextField(
                                            controller: l_pass,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10))),
                                                hintText: "Password",
                                                prefixIcon: IconTheme(
                                                  data: IconThemeData(color: Colors.black87),
                                                  child: Icon(Icons.password_outlined),
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Forgot password?",style: TextStyle(
                                                fontSize:17,
                                                color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white
                                            ),),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.black54,
                                                        shadowColor: Colors.blueGrey,
                                                        elevation: 12,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(60)))),
                                                    onPressed: () {
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  zoomable_drawer()));
                                                    },
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 32,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
