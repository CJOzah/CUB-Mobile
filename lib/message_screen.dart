import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'contact_us.dart';

class MessageScreen extends StatelessWidget {

  static String id = 'MessageScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              height: 120.0,
              width: double.infinity,
              color: primaryRed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                Padding(
              padding: const EdgeInsets.only(bottom: 12.0, right: 5.0),
              child: Container(
              height: 28.0,
              width: 28.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
              ),
              child: iconButton(
                icon: Icons.message,
                size: 14.0,
                color: primaryRed, function: null,
              )),
            ),
                  Container(
                    height: 30.0,
                    width: 30.0,
                    color: accentColor.withOpacity(0.4),
                    child: iconButton(function: () => Navigator.pop(context),
                        color: Colors.white.withOpacity(0.5),
                        size: 15.0,
                        icon: FontAwesomeIcons.times),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: EdgeInsets.only(left: 12.0, top: 90.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 120.0,
                width: 370.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15.0),
                      child: Text(
                        "Message Us",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    HorizontalLine(width: 400.0, height: 0.5, color: dividerColor,),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            LetterIcons(text: "C", color: Color(0xFFE45E53),),
                            SizedBox(
                              width: 12.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Contact Us",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  "Good day, Welcome to CUB",
                                  style: TextStyle(
                                    color: dividerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUs(),
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.only(left: 12.0, top: 225.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          height: 280.0,
          width: 370.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                child: Text(
                  "FAQS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              HorizontalLine(width: 400.0, height: 0.5, color: dividerColor,),
              LetterIconsWithText(text: "E-CHANNELS", iconColor: Color(0xFF47B5AA), iconText: "E",),
              Padding(
                padding: const EdgeInsets.only(left: 58.0),
                child: HorizontalLine(width: 305.0, color: dividerColor, height: 0.5,),
              ),
              LetterIconsWithText(text: "PROMO ACCOUNTS", iconColor: Color(0xFFA2877C), iconText: "P",),
              Padding(
                padding: const EdgeInsets.only(left: 58.0),
                child: HorizontalLine(width: 305.0, color: dividerColor, height: 0.5,),
              ),
              LetterIconsWithText(text: "POS TRANSACTION", iconColor: Color(0xFFA2877C), iconText: "P",),
              HorizontalLine(width: double.infinity, color: dividerColor, height: 0.5,),
              Padding(
                padding: EdgeInsets.only(left: 15.0,),
                child: Text(
                  "Show more categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}

class LetterIconsWithText extends StatelessWidget {
  const LetterIconsWithText({
    Key key, this.text, this.iconColor, this.iconText,
  }) : super(key: key);

  final String text;
  final Color iconColor;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 5.0),
      child: Row(
        children: <Widget>[
          LetterIcons(text: iconText, color: iconColor),
          SizedBox(width: 10.0,),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}

class LetterIcons extends StatelessWidget {
  const LetterIcons({
    Key key, this.text, this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(text,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
        ),
        ),
      ),
    );
  }
}
