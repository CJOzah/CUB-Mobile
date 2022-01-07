import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cub_mobile/home_screens/home.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreenLifestyle extends StatefulWidget {

  static String id = 'MenuScreenLifestyle';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreenLifestyle> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation _colorTween;

  void openComingSoonDialogue(BuildContext context) {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    _colorTween = ColorTween(begin: primaryRedDark, end: Colors.white)
        .animate(_animationController);
    _animationController.forward();
    showDialog(
      context: context,
      builder: (context) =>
          Theme(
            data: Theme.of(context).copyWith(
                primaryColor: primaryRedLight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  elevation: 10.0,
                  semanticContainer: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryRedDark,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: 250.0,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                iconButton(
                                  function: null, icon: Icons.more_vert,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                iconButton(function: null, icon: Icons.share,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                iconButton(function: null, icon: Icons.close,
                                  size: 20.0,
                                  color: primaryRedLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextLiquidFill(
                          text: 'COMING SOON',
                          boxBackgroundColor: primaryRedDark,
                          waveColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 40.0,
                            fontFamily: "Horizon",
                          ),
                          boxHeight: 40.0,
                          boxWidth: 280.0,
                        ),
                        ColorizeAnimatedTextKit(
                          text: [
                            "Hi, This feature is coming soon",
                          ],
                          isRepeatingAnimation: false,
                          textStyle: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Horizon"
                          ),
                          colors: [
                            Colors.white,
                            primaryRed,
                            Colors.white,
                          ],
                          textAlign: TextAlign.start,
                        ),
                        AnimatedBuilder(
                          animation: _colorTween,
                          builder: (context, child) =>
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0, right: 100.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 35.0,
                                  minWidth: double.infinity,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: _colorTween.value, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text("OK", style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),),
                                ),
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Tapables(
                                text: "Contact Us", ontap: null, color: Colors
                                  .white, size: 12.0,),
                              SizedBox(width: 20.0,),
                              Tapables(
                                text: "Unsubscribe", ontap: null, color: Colors
                                  .white, size: 12.0,),
                            ],
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  bool othersDrop = false;

  IconData othersDropDown = Icons.arrow_drop_down;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Color(0xFF3A3A3D),
          width: 10.0,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 625.0,
                  width: 400.0,
                  child: ListView(
                    padding: EdgeInsets.only(left: 4.0, right: 20.0),
                    children: <Widget>[
                      MoreItemsBuilder(
                        text: "Movies",
                        icon: Icons.movie_creation,
                        textColor: Colors.white,
                        height: 35.0,
                        width: 35.0,
                        containerColor: Color(0xFF707070),
                        iconColor: Colors.white,
                        onpressed: () => openComingSoonDialogue
                          (context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                      MoreItemsBuilder(
                        text: "Events",
                        icon: Icons.event_note,
                        textColor: Colors.white,
                        height: 35.0,
                        width: 35.0,
                        containerColor: Color(0xFF707070),
                        iconColor: Colors.white,
                        onpressed: () => openComingSoonDialogue
                          (context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                      MoreItemsBuilder(
                        text: "Food",
                        icon: Icons.fastfood,
                        textColor: Colors.white,
                        height: 35.0,
                        width: 35.0,
                        containerColor: Color(0xFF707070),
                        iconColor: Colors.white,
                        onpressed: () => openComingSoonDialogue
                          (context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                      MoreItemsBuilder(
                        text: "History",
                        icon: Icons.history,
                        textColor: Colors.white,
                        height: 35.0,
                        width: 35.0,
                        containerColor: Color(0xFF707070),
                        iconColor: Colors.white,
                        onpressed: () => openComingSoonDialogue
                          (context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                      MoreItemsBuilder(
                        text: "Flight Tickets",
                        icon: FontAwesomeIcons.plane,
                        textColor: Colors.white,
                        iconSize: 20.0,
                        height: 35.0,
                        width: 35.0,
                        containerColor: Color(0xFF707070),
                        iconColor: Colors.white,
                        onpressed: () => openComingSoonDialogue
                          (context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                      Row(
                        children: <Widget>[
                          MoreItemsBuilder(
                            text: "Others",
                            icon: Icons.more_horiz,
                            textColor: Colors.white,
                            height: 35.0,
                            width: 35.0,
                            containerColor: Color(0xFF707070),
                            iconColor: Colors.white,
                            onpressed: () => openComingSoonDialogue
                              (context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 78.0),
                            child: iconButton(function: () {
                              setState(() {
                                if(othersDrop==false) {othersDrop = true; othersDropDown = Icons.arrow_drop_up;}
                                else {othersDrop = false; othersDropDown = Icons.arrow_drop_down;}
                              });
                            }, icon: othersDropDown,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),

                      othersDrop ? OthersMoreItems() :

                      Padding(
                        padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                        child: HorizontalLine(width: 20.0, height: 0.4, color: dividerColor,),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 110.0,
                width: double.infinity,
                color: Color(0xFF28282A),
                child: Column(
                  children: <Widget>[
                    MoreItemsBuilder(
                      icon: Icons.account_balance,
                      text: "Banking",
                      textColor: Colors.white,
                      containerColor: Color(0xFF707070),
                      height: 35.0,
                      width: 35.0,
                      iconColor: Colors.white,
                      onpressed: () => Navigator.pushReplacementNamed(context, BankingScreen.id),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
                      child: HorizontalLine(width: 300.0, height: 0.4, color: dividerColor,),
                    ),
                    MoreItemsBuilder(
                      icon: FontAwesomeIcons.doorOpen,
                      text: "Sign out",
                      textColor: Colors.white,
                      containerColor: Color(0xFF707070),
                      iconSize: 20.0,
                      height: 35.0,
                      width: 35.0,
                      iconColor: Colors.white,
                      onpressed: () => Navigator.pushNamed(context, Home.id),
                    ),
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

class OthersMoreItems extends StatefulWidget {
  const OthersMoreItems({
    Key key,
  }) : super(key: key);

  @override
  _OthersMoreItemsState createState() => _OthersMoreItemsState();
}

class _OthersMoreItemsState extends State<OthersMoreItems> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation _colorTween;

  void openComingSoonDialogue(BuildContext context) {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    _colorTween = ColorTween(begin: primaryRedDark, end: Colors.white)
        .animate(_animationController);
    _animationController.forward();
    showDialog(
      context: context,
      builder: (context) =>
          Theme(
            data: Theme.of(context).copyWith(
                primaryColor: primaryRedLight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  elevation: 10.0,
                  semanticContainer: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryRedDark,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: 250.0,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                iconButton(
                                  function: null, icon: Icons.more_vert,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                                iconButton(function: null, icon: Icons.share,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                iconButton(function: null, icon: Icons.close,
                                  size: 20.0,
                                  color: primaryRedLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextLiquidFill(
                          text: 'COMING SOON',
                          boxBackgroundColor: primaryRedDark,
                          waveColor: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 40.0,
                            fontFamily: "Horizon",
                          ),
                          boxHeight: 40.0,
                          boxWidth: 280.0,
                        ),
                        ColorizeAnimatedTextKit(
                          text: [
                            "Hi, This feature is coming soon",
                          ],
                          isRepeatingAnimation: false,
                          textStyle: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Horizon"
                          ),
                          colors: [
                            Colors.white,
                            primaryRed,
                            Colors.white,
                          ],
                          textAlign: TextAlign.start,
                        ),
                        AnimatedBuilder(
                          animation: _colorTween,
                          builder: (context, child) =>
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 100.0, right: 100.0),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  height: 35.0,
                                  minWidth: double.infinity,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: _colorTween.value, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text("OK", style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),),
                                ),
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Tapables(
                                text: "Contact Us", ontap: null, color: Colors
                                  .white, size: 12.0,),
                              SizedBox(width: 20.0,),
                              Tapables(
                                text: "Unsubscribe", ontap: null, color: Colors
                                  .white, size: 12.0,),
                            ],
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 300.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "Settings",
              icon: Icons.settings,
              textColor: Colors.white,
              iconSize: 20.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "ATM/Branch Locator",
              icon: Icons.location_on,
              textColor: Colors.white,
              iconSize: 30.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "Contact Us",
              icon: Icons.phone,
              textColor: Colors.white,
              iconSize: 28.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "My Inbox",
              icon: Icons.mail_outline,
              textColor: Colors.white,
              iconSize: 25.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "Tour",
              icon: FontAwesomeIcons.binoculars,
              textColor: Colors.white,
              iconSize: 20.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: MoreItemsBuilder(
              text: "FAQ",
              icon: FontAwesomeIcons.question,
              textColor: Colors.white,
              iconSize: 20.0,
              height: 35.0,
              width: 35.0,
              containerColor: Color(0xFF707070),
              iconColor: Colors.white,
              onpressed: () => openComingSoonDialogue
                (context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35.0,top:3.0, bottom: 6.0),
            child: HorizontalLine(width: 250.0, height: 0.4, color: dividerColor,),
          ),
        ],
      ),
    );
  }
}