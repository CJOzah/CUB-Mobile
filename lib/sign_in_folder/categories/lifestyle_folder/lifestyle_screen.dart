import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/menu_screen_lifestyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';
import '../../../utils.dart';
import '../../sign_in_category.dart';

class LifeStyleScreen extends StatefulWidget {

  static String id = 'LifeStyleScreen';

  @override
  _LifeStyleScreenState createState() => _LifeStyleScreenState();
}

class _LifeStyleScreenState extends State<LifeStyleScreen> with TickerProviderStateMixin {

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 110.0, right: 0.0),
              height: 55.0,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("LOGO",
                    style: TextStyle(color: Colors.black),
                  ),
                  Avatar(),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MenuScreenLifestyle(),
      floatingActionButton: FloatingActionButt(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Lifestyle",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: HorizontalLine(
                        height: 4.0,
                        width: 115.0,
                        color: primaryRed,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 480.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ListViewContainers(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      c_height: 120.0,
                                      Ccolor: Colors.lightBlueAccent.shade100,
                                      Icolor: Colors.blue,
                                      Tcolor: Colors.white,
                                      I_size:  80.0,
                                      icon: Icons.event_note,
                                      I_padding: const EdgeInsets.only(top: 0.0),
                                      text: "Events",
                                        onTap: () {
                                          openComingSoonDialogue
                                            (context);
                                        }
                                    ),
                                    SizedBox(height: 5.0,),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(context, BankingScreen.id),
                                      child: Container(
                                        height: 250.0,
                                        width: 165.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                            image: AssetImage("images/banking.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 190.0, left: 12.0),
                                          child: Text("Switch to Banking", textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5.0,),
                                Column(
                                  children: <Widget>[
                                   Row(
                                     children: <Widget>[
                                       InkWell(
                                         child: Container(
                                           height: 250.0,
                                           width: 165.0,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(5.0),
                                             image: DecorationImage(
                                               image: AssetImage("images/movie_image.jpeg"),
                                               fit: BoxFit.cover,
                                             ),
                                           ),
                                           child: Padding(
                                             padding: const EdgeInsets.only(top: 190.0, left: 12.0),
                                             child: Text("Movies", textAlign: TextAlign.justify,
                                               style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 18.0,
                                               ),
                                             ),
                                           ),
                                         ),
                                           onTap: () {
                                             openComingSoonDialogue
                                               (context);
                                           }
                                       ),
                                       SizedBox(width: 5.0,),
                                       Column(
                                         children: <Widget>[
                                           ListViewContainers(
                                             padding: const EdgeInsets.only(top: 0.0),
                                             c_height: 120.0,
                                             Ccolor: Color(0xFFFF8997),
                                             Icolor: Color(0xFFE36977),
                                             Tcolor: Colors.white,
                                             I_size:  60.0,
                                             icon: FontAwesomeIcons.plane,
                                             I_padding: const EdgeInsets.only(top: 0.0),
                                             text: "Flight Payment",
                                               onTap: () {
                                                 openComingSoonDialogue
                                                   (context);
                                               }
                                           ),
                                           SizedBox(height: 5.0,),
                                           ListViewContainers(
                                             padding: const EdgeInsets.only(top: 0.0),
                                             c_height: 120.0,
                                             Ccolor: Color(0xFFFFBE72),
                                             Icolor: Color(0xFFDE9949),
                                             Tcolor: Colors.white,
                                             I_size:  60.0,
                                             icon: Icons.fastfood,
                                             I_padding: const EdgeInsets.only(bottom: 0.0),
                                             text: "Food",
                                               onTap: () {
                                                 openComingSoonDialogue
                                                   (context);
                                               }
                                           ),
                                         ],
                                       ),
                                     ],
                                   ),
                                    SizedBox(height: 5.0,),
          InkWell(
            child: Container(
              height: 120.0,
              width: 335.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFFC99BFF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Icon(
                          FontAwesomeIcons.basketballBall,
                          color: Color(0xFF7C27E0),
                          size: 60.0,
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Text("Sports & Gaming",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
              onTap: () {
                openComingSoonDialogue
                  (context);
              }
          ),
                                  ],
                                ),
                                SizedBox(width: 5.0,),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 250.0),
                                  child: InkWell(
                                    child: Container(
                                      height: 120.0,
                                      width: 335.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: Color(0xFF0D0D0D),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10.0),
                                              child: Icon(
                                                Icons.star,
                                                color: Color(0xFFFDB502),
                                                size: 50.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 0.0),
                                              child: Text("Premium Lifestyle",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                      onTap: () {
                                        openComingSoonDialogue
                                          (context);
                                      }
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
