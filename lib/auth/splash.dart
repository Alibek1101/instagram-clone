import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/sign_in.dart';

import '../page/main_page.dart';
import '../service/auth_service.dart';


class Splash_Page extends StatefulWidget {
  static final String id = "Splash_Page";
  const Splash_Page({super.key});

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      _callNextPage();
    });
  }
  _callNextPage() {

    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, Home_page.id);
    } else {
      Navigator.pushReplacementNamed(context, Log_In.id);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[Colors.pink, Colors.purple]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: AssetImage("assets/insta_logo.png"),fit:BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                "Instagram",style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.w600,fontFamily: "Billabong"),),
            ),
          ],
        ),
      ),
    );
  }
}