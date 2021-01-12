import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'database_users.dart';
import 'main.dart';

class ProfileScreen extends StatelessWidget {


  static String id = 'ProfileScreen';

  @override

  String firstName = "OGHENENYERHOVWO";
  String middleName = "CANAAN";
  String surname = "OZAH";
  String mobileNumber = "+2347056524189";
  String bvn = "23234332342";

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
          padding: EdgeInsets.only(bottom: 15.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 15.0),
                height: 45.0,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    iconButton(
                      icon: FontAwesomeIcons.longArrowAltLeft,
                      color: Colors.black,
                      size: 30.0,
                      function: () => Navigator.pop(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 90.0),
                      child: Text("My Profile",
                      style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(70.0)),
                      child: Container(
                        height: 82.0,
                        width: 82.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/avatar.jpeg"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 38.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Full Name"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["firstName"]} ${Provider.of<User>(context, listen: false).userDetails["lastName"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    SizedBox(height: 10.0,),
                    Text("Mobile Number"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["mobileNumber"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              AshColoredDetailContainer(text: "Basic Information",),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("First Name"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["firstName"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0,),
                    Text("Middle Name"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["lastName"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0,),
                    Text("Full Name"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["firstName"]} ${Provider.of<User>(context, listen: false).userDetails["lastName"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              AshColoredDetailContainer(text: "Contact information",),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Email"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["email"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          iconButton(function: null, icon: FontAwesomeIcons.pen, size: 15.0,color: primaryRed,),
                          Tapables(text: "Edit", ontap: null, color: primaryRed, size: 15.0,)
                        ],
                      ),
                    ),
                    Text("Mobile number"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["mobileNumber"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              AshColoredDetailContainer(text: "Security information"),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("BVN"),
                    Text(
                      "${Provider.of<User>(context, listen: false).userDetails["bvn"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     iconButton(function: null, icon: FontAwesomeIcons.eye, color: primaryRed,size: 10.0,),
                    //     Tapables(text: "View", ontap: null, color: primaryRed, size: 10.0,)
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AshColoredDetailContainer extends StatelessWidget {
  const AshColoredDetailContainer({
    Key key, this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.0,
      width: double.infinity,
      color: Color(0xFFD3D3D3),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
        child: Text(text,
        style: TextStyle(color: Color(0xFF777777)),
        ),
      ),
    );
  }
}
