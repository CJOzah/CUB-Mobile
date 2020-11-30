import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/sign_in_folder/sign_in_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';

class MoreScreen extends StatelessWidget {

  static String id = 'MoreScreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButt(),
        body: Container(
          padding: EdgeInsets.only(left: 30.0, bottom: 100.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              iconButton(
                function: () {
                  Navigator.pop(context);
                },
                icon: FontAwesomeIcons.longArrowAltLeft,
                size: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 30.0),
                    child: Text(
                      "More",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HorizontalLine(
                    width: double.infinity,
                    height: 4.0,
                    color: primaryRed,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MoreItemsBuilder(
                      icon: FontAwesomeIcons.phone,
                      iconColor: Colors.black,
                      text: "Contact Us",
                      iconSize: 16.0,
                      textColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, bottom: 4.0, left: 14.0),
                      child: HorizontalLine(
                        width: 300.0,
                        height: 1.0,
                        color: dividerColor.withOpacity(0.50),
                      ),
                    ),
                    MoreItemsBuilder(
                      icon: Icons.mail_outline,
                      text: "Inbox",
                      iconSize: 20.0,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, bottom: 4.0, left: 14.0),
                      child: HorizontalLine(
                        width: 300.0,
                        height: 1.0,
                        color: dividerColor.withOpacity(0.50),
                      ),
                    ),
                    MoreItemsBuilder(
                      icon: FontAwesomeIcons.question,
                      iconColor: Colors.black,
                      text: "FAQ",
                      iconSize: 17.0,
                      textColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, bottom: 4.0, left: 14.0),
                      child: HorizontalLine(
                        width: 300.0,
                        height: 1.0,
                        color: dividerColor.withOpacity(0.50),
                      ),
                    ),
                    MoreItemsBuilder(
                      icon: FontAwesomeIcons.binoculars,
                      iconColor: Colors.black,
                      text: "Tour",
                      iconSize: 17.0,
                      textColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, bottom: 4.0, left: 14.0),
                      child: HorizontalLine(
                        width: 300.0,
                        height: 1.0,
                        color: dividerColor.withOpacity(0.50),
                      ),
                    ),
                    MoreItemsBuilder(
                      icon: Icons.location_on,
                      iconColor: Colors.black,
                      text: "ATM & Branches",
                      iconSize: 20.0,
                      textColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 30.0, bottom: 4.0, left: 14.0),
                      child: HorizontalLine(
                        width: 300.0,
                        height: 1.0,
                        color: dividerColor.withOpacity(0.50),
                      ),
                    ),
                    MoreItemsBuilder(
                      icon: FontAwesomeIcons.info,
                      iconColor: Colors.black,
                      text: "About",
                      iconSize: 16.0,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 20.0),
                    child: HorizontalLine(
                      width: 260.0,
                      height: 0.9,
                      color: secondaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0, right: 90.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MoreScreenIcon(
                          function: null,
                          icon: FontAwesomeIcons.twitter,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.instagram),
                          onPressed: null,
                          color: Colors.black,
                          iconSize: 30.0,
                          disabledColor: Colors.black,
                        ),
                        MoreScreenIcon(
                          function: null,
                          icon: FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 15.0,
                        ),
                        MoreScreenIcon(
                          function: null,
                          icon: FontAwesomeIcons.youtube,
                          color: Colors.white,
                          size: 15.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text("Bankgroup"),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreItemsBuilder extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  Color iconColor = primaryRed;
  Color containerColor = primaryRedLight;
  final double iconSize;
  double height = 25.0;
  double width = 25.0;
  Function onpressed;

   MoreItemsBuilder({
    Key key,
    @required this.icon,
    @required this.text,
    this.iconSize, this.onpressed, this.height, this.width, this.textColor, this.iconColor, this.containerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: onpressed,
    );
  }
}

class MoreScreenIcon extends StatelessWidget {
  final Function function;
  final IconData icon;
  final Color color;
  final double size;

  const MoreScreenIcon(
      {Key key, this.function, this.icon, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: iconButton(
        function: function,
        icon: icon,
        color: color,
        size: size,
      ),
    );
  }
}
