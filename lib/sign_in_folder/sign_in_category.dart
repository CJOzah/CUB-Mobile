import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/notification_handler.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/lifestyle_screen.dart';
import 'package:cub_mobile/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../database_users.dart';
import '../message_screen.dart';


// ignore: must_be_immutable
class SignInCategory extends StatefulWidget {

  static String id = 'SignInCategory';

  @override
  _SignInCategoryState createState() => _SignInCategoryState();
}

class _SignInCategoryState extends State<SignInCategory> {
  int inDex;

  @override
  void initState() {
    if(Platform.isIOS){
      NotificationHandler().getIOSPermission();
    } else{
      NotificationHandler().saveTokenAndroid();
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButt(),
      body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    iconButton(
                      function: () async {
                        await auth.FirebaseAuth.instance.signOut(); Navigator.pop(context);
                        },
                      icon: FontAwesomeIcons.doorOpen,
                    ),
                   Avatar(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  "Welcome ${Provider.of<User>(context, listen: false).userDetails["firstName"].toString().toUpperCase()} Choose how we may serve you",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 20.0, right: 10.0),
                child: HorizontalLine(
                  height: 4.0,
                  width: 100.0,
                  color: primaryRed,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 0.50,
                  height: 450.0,
                  autoPlay: true,
                  pageSnapping: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    index = inDex;
                  }
                ),
                items: <Widget>[
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     InkWell(
                       onTap: () {
                         Navigator.pushNamed(context, BankingScreen.id);
                       },
                       child: Card(
                         semanticContainer: true,
                         elevation: 5.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         ),
                         child: Container(
                           child: ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                               child: Stack(
                                 alignment: AlignmentDirectional.bottomStart,
                                 children: <Widget>[
                                   Container(
                                     height: 300.0,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                       image: DecorationImage(
                                         image: AssetImage("images/banking.jpeg"),
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom: 15.0, left: 8.0),
                                     child: Text("Banking",
                                       style: TextStyle(color: Colors.white,
                                         fontSize: 30.0,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                 ],
                               )
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0),
                       child: Text(
                         "Send Money, Account\nBalance, Airtime, Pay\nbills, withdrawals",
                         style: TextStyle(
                           color: Colors.black,
                         ),
                       ),
                     ),
                   ],
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     InkWell(
                       onTap: () {
                         Navigator.pushNamed(context, LifeStyleScreen.id);
                       },
                       child: Card(
                         semanticContainer: true,
                         elevation: 5.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         ),
                         child: Container(
                           child: ClipRRect(
                               borderRadius: BorderRadius.all(Radius.circular(20.0)),
                               child: Stack(
                                 alignment: AlignmentDirectional.bottomStart,
                                 children: <Widget>[
                                   Container(
                                     height: 300.0,
                                     width: 250.0,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                       image: DecorationImage(
                                         image: AssetImage("images/lifestyle.jpeg"),
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom: 15.0, left: 8.0),
                                     child: Text("Lifestyle",
                                       style: TextStyle(color: Colors.white,
                                         fontSize: 30.0,
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                 ],
                               )
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0),
                       child: Text(
                         "Movies, Food, Events",
                         style: TextStyle(
                           color: Colors.black,
                         ),
                       ),
                     ),
                   ],
                 ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
