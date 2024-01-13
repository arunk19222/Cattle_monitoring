import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_veltech_project/firebase_actions.dart';
import 'package:flutter_veltech_project/zoom_drawer.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  PageController pageController = PageController();
  TextEditingController s_name = TextEditingController();
  TextEditingController s_email = TextEditingController();
  TextEditingController s_pass = TextEditingController();
  TextEditingController l_email = TextEditingController();
  TextEditingController l_pass = TextEditingController();
  TextEditingController reset_email = TextEditingController();
  var issign_in_page = true;
  dynamic s_name_error_text = null;
  dynamic s_mail_error_text = null;
  dynamic s_password_error_text = null;
  dynamic l_mail_error_text = null;
  dynamic l_password_error_text = null;
  dynamic reset_email_error_text = null;
  bool password_visibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:Stack(
        children: [
          Container(decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              )
          ),),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX:1,sigmaY:1),
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
                                  //Sign Up Section  ------------------------
                                  SingleChildScrollView(
                                    child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top:20),
                                              child: TextFormField(
                                                controller: s_name,
                                                onTap: (){
                                                  setState(() {
                                                    s_name_error_text = null;
                                                  });
                                                },
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorText: s_name_error_text,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10))),
                                                    hintText: "Name",
                                                    prefixIcon: IconTheme(
                                                      data: IconThemeData(color: Colors.black87),
                                                      child: Icon(Icons.account_box_rounded),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:50),
                                              child: TextFormField(
                                                controller: s_email,
                                                keyboardType: TextInputType.emailAddress,
                                                onTap: (){
                                                  setState(() {
                                                    s_mail_error_text = null;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorText: s_mail_error_text,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10))),
                                                    hintText: "Mail",
                                                    prefixIcon: IconTheme(
                                                      data: IconThemeData(color: Colors.black87),
                                                      child: Icon(Icons.mail),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.only(top:50),
                                              child: TextFormField(
                                                controller: s_pass,
                                                obscureText: password_visibility,
                                                obscuringCharacter:"*",
                                                onTap: (){
                                                  setState(() {
                                                    s_password_error_text = null;
                                                  });
                                                },
                                                keyboardType: TextInputType.text,
                                                onEditingComplete: (){

                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorText: s_password_error_text,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10))),
                                                    hintText: "Password",
                                                    prefixIcon: IconTheme(
                                                      data: IconThemeData(color: Colors.black87),
                                                      child: Icon(CupertinoIcons.lock),
                                                    ),suffixIcon: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        password_visibility = password_visibility?false:true;
                                                      });
                                                    },
                                                    child: Icon(password_visibility?Icons.visibility:Icons.visibility_off,color: Colors.black,)
                                                )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:60,right:10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: ()async{
                                                      if(!s_name.text.isEmpty&&s_name.text!=""){
                                                        setState(() {
                                                          s_name_error_text = null;
                                                        });
                                                        if(s_email.text!=""&&!s_email.text.isEmpty){
                                                          setState(() {
                                                            s_mail_error_text =null;
                                                          });
                                                          if(!s_pass.text.isEmpty&&s_pass.text!=""){

                                                            var error = await create_account(name:s_name.text,email: s_email.text, password:s_pass.text);
                                                            if(error==null){
                                                              FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).set({"name":s_name.text.toUpperCase()});
                                                              var set_data = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid);
                                                              set_data.doc("COW").set({"null":0});
                                                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                                backgroundColor: Colors.black,
                                                                content: Text("Account Created Successfully",style: TextStyle(color: Colors.white),),));
                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>zoomable_drawer()));
                                                            }else{
                                                              //snackbar
                                                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                                backgroundColor: Colors.red,
                                                                content: Text(error.toString(),style: TextStyle(color: Colors.white),),));
                                                            }
                                                          }else{
                                                            setState(() {
                                                              s_name_error_text = null;
                                                              s_mail_error_text = null;
                                                              s_password_error_text = "*Fill";
                                                            });
                                                          }
                                                        } else{
                                                          setState(() {
                                                            s_name_error_text = null;
                                                            s_mail_error_text = "*Fill";
                                                            s_password_error_text = null;
                                                          });
                                                        }
                                                      }else{
                                                        setState(() {
                                                          s_name_error_text = "*Fill";
                                                          s_mail_error_text = null;
                                                          s_password_error_text = null;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      width:60,
                                                      height:60,
                                                      child: Icon(CupertinoIcons.arrow_right,size:30,color: Colors.white,),
                                                      decoration: BoxDecoration(color: Colors.black,boxShadow:[BoxShadow(color: Colors.white60,blurRadius:5,spreadRadius:4)],border: Border.all(color: Colors.black87,width:1),borderRadius: BorderRadius.all(Radius.circular(60))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  //Login Section-----------------------------
                                  SingleChildScrollView(
                                    child: Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top:20),
                                              child: TextFormField(
                                                controller: l_email,
                                                keyboardType: TextInputType.emailAddress,
                                                onTap: (){
                                                  setState(() {
                                                    l_mail_error_text = null;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorText: l_mail_error_text,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10))),
                                                    hintText: "Mail",
                                                    prefixIcon: IconTheme(
                                                      data: IconThemeData(color: Colors.black87),
                                                      child: Icon(Icons.mail),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:50),
                                              child: TextFormField(
                                                controller: l_pass,
                                                obscureText: password_visibility,
                                                obscuringCharacter: '*',
                                                onTap: (){
                                                  setState(() {
                                                    l_password_error_text = null;
                                                  });
                                                },
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    errorText: l_password_error_text,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(10))),
                                                    hintText: "Password",
                                                    prefixIcon: IconTheme(
                                                      data: IconThemeData(color: Colors.black87),
                                                      child: Icon(CupertinoIcons.lock_fill),
                                                    ),suffixIcon: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        password_visibility = password_visibility?false:true;
                                                      });
                                                    },
                                                    child: Icon(password_visibility?Icons.visibility:Icons.visibility_off,color: Colors.black,)
                                                )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:10),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: GestureDetector(
                                                  onTap: (){
                                                    showDialog(context: context,builder: (context){
                                                      return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                                                        return AlertDialog(
                                                          title: Center(child: Text('Reset Password')),
                                                          content: Container(
                                                            height:150,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Center(
                                                                  child: Container(width:MediaQuery.of(context).size.width,child: TextField(
                                                                    controller:reset_email,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    onTap: (){
                                                                      setState(() {
                                                                        reset_email_error_text = null;
                                                                      });
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        errorText: reset_email_error_text,
                                                                        fillColor: Colors.white,
                                                                        filled: true,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                        hintText: "Email",
                                                                        prefixIcon: IconTheme(
                                                                          data: IconThemeData(color: Colors.black87),
                                                                          child: Icon(Icons.mail),
                                                                        )),
                                                                  ),),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                          actions: [ElevatedButton(onPressed: (){
                                                            var regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                                            if(regex.hasMatch(reset_email.text)){
                                                              try{
                                                                FirebaseAuth.instance.sendPasswordResetEmail(email: reset_email.text);
                                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                                  backgroundColor: Colors.black,
                                                                  content: Text("Check Your Mail (Including Spam Folder)",style: TextStyle(color: Colors.white),),));
                                                              }catch(e){
                                                                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                                  backgroundColor: Colors.red,
                                                                  content: Text(e.toString(),style: TextStyle(color: Colors.white),),));
                                                              }
                                                            }else{
                                                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                                backgroundColor: Colors.red,
                                                                content: Text("Invalid Email",style: TextStyle(color: Colors.white),),));
                                                            }
                                                          },
                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.black,elevation:6,shadowColor: Colors.white) ,
                                                              child: Text("Yes",style: TextStyle(color: Colors.white,fontSize:18),)),
                                                            ElevatedButton(onPressed:(){},
                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black,elevation:6,shadowColor: Colors.white) ,
                                                                child: Text("No",style: TextStyle(color: Colors.white,fontSize:18),))],
                                                        );
                                                      },);
                                                    });
                                                  },
                                                  child: Text("Forgot password?",style: TextStyle(
                                                      fontSize:17,
                                                      color: Colors.white,decoration: TextDecoration.underline,decorationColor: Colors.white
                                                  ),),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:40,right:10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async{
                                                      if(!l_email.text.isEmpty||l_email.text!=""){
                                                        setState(() {
                                                          l_mail_error_text = null;
                                                        });
                                                        if(!l_pass.text.isEmpty||l_pass.text!=""){
                                                          setState(() {
                                                            l_password_error_text = null;
                                                          });
                                                          var error = await signIn_account(email: l_email.text, password:l_pass.text);
                                                          if(error==null){
                                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>zoomable_drawer()));
                                                          }else{
                                                            //snackbar
                                                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                              backgroundColor: Colors.red,
                                                              content: Text("Invalid username or password",style: TextStyle(color: Colors.white),),));
                                                          }
                                                        }else{
                                                          setState(() {
                                                            l_mail_error_text = null;
                                                            l_password_error_text="*Fill";
                                                          });
                                                        }
                                                      }else{
                                                        setState(() {
                                                          l_mail_error_text = "*Fill";
                                                          l_password_error_text=null;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      width:60,
                                                      height:60,
                                                      child: Icon(CupertinoIcons.arrow_right,size:30,color: Colors.white,),
                                                      decoration: BoxDecoration(color: Colors.black,boxShadow:[BoxShadow(color: Colors.white60,blurRadius:5,spreadRadius:4)],border: Border.all(color: Colors.black87,width:1),borderRadius: BorderRadius.all(Radius.circular(60))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
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
