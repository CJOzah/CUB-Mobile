import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/menu_screen_lifestyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';
import '../../../utils.dart';
import '../../sign_in_category.dart';

class LifeStyleScreen extends StatelessWidget {

  static String id = 'LifeStyleScreen';

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
                                       Container(
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
