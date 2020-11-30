import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen_categories/send_money_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/menu_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/lifestyle_screen.dart';
import 'package:cub_mobile/sign_in_folder/sign_in_category.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../database_users.dart';

class BankingScreen extends StatelessWidget{

  static String id = 'BankingScreen';
  String _text = "+2347056524189";
  var isObscure = true;

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
      drawer: MenuScreen(),
      floatingActionButton: Hero(
          tag: Object(),
          child: FloatingActionButt()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: UserDetailCard(isObscure: isObscure, text: "${Provider.of<User>(context, listen: false).userDetails["accountNumber"]}",),
                ),
               Column(
                 children: [
                   Container(
                     height: 40.0,
                     width: double.infinity,
                     color: Colors.white,
                     child:
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                       child: Text(
                         "Banking Quick Links",
                         style: TextStyle(
                           fontSize: 20.0,
                         ),
                       ),
                     ),
                   ),
                   Container(
                     height: 420.0,
                     width: double.infinity,
                     color: Colors.white,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 10.0,left: 0.0, right: 0.0),
                       child: ListView(
                         scrollDirection: Axis.horizontal,
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.only(left:15.0),
                             child: Column(
                               children: <Widget>[
                                 Row(
                                   children: <Widget>[
                                     ListViewContainers(
                                       padding: const EdgeInsets.only(top: 15.0),
                                       c_height: 120.0,
                                       Ccolor: Colors.lightBlueAccent.shade100,
                                       Icolor: Colors.blue,
                                       Tcolor: Colors.blue,
                                       I_size:  40.0,
                                       icon: Icons.compare_arrows,
                                       I_padding: const EdgeInsets.only(top: 15.0),
                                       text: "Send Money",
                                       onTap: () => Navigator.pushNamed(context, SendMoneyScreen.id),
                                     ),
                                     SizedBox(width: 5.0,),
                                     ListViewContainers(
                                       padding: const EdgeInsets.only(top: 5.0),
                                       c_height: 120.0,
                                       Ccolor: Colors.redAccent.shade100,
                                       Icolor: primaryRedDark,
                                       Tcolor: Colors.white,
                                       I_size:  50.0,
                                       icon: FontAwesomeIcons.clock,
                                       I_padding: const EdgeInsets.only(bottom: 15.0, left: 45.0),
                                       text: "Transaction History",
                                     ),
                                     SizedBox(width: 5.0,),
                                     ListViewContainers(
                                       padding: const EdgeInsets.only(top: 0.0),
                                       c_height: 120.0,
                                       Ccolor: Color(0xFF60B247),
                                       Icolor: Color(0xFF459A2B),
                                       Tcolor: Colors.white,
                                       I_size:  70.0,
                                       icon: FontAwesomeIcons.tv,
                                       I_padding: const EdgeInsets.only(bottom: 0.0),
                                       text: "Tv subscriptions",
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: 5.0,),
                                 Row(
                                   children: <Widget>[
                                     InkWell(
                                       onTap: () => Navigator.pushNamed(context, LifeStyleScreen.id),
                                       child: Container(
                                         height: 250.0,
                                         width: 165.0,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5.0),
                                           image: DecorationImage(
                                             image: AssetImage("images/lifestyle.jpeg"),
                                           ),
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.only(top: 190.0, left: 12.0),
                                           child: Text("Lifestyle", textAlign: TextAlign.justify,
                                             style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 18.0,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(width: 5.0,),
                                     Column(
                                       children: <Widget>[
                                         ListViewContainers(
                                           padding: const EdgeInsets.only(top: 15.0),
                                           c_height: 120.0,
                                           Ccolor: Color(0xFFA0E1FF),
                                           Icolor: Color(0xFF107EB1),
                                           Tcolor: Colors.white,
                                           I_size:  40.0,
                                           icon: FontAwesomeIcons.coins,
                                           I_padding: const EdgeInsets.only(top: 15.0),
                                           text: "Send Money",
                                         ),
                                         SizedBox(height: 5.0,),
                                         ListViewContainers(
                                           padding: const EdgeInsets.only(bottom: 0.0),
                                           c_height: 120.0,
                                           Ccolor: Color(0xFFFFBE72),
                                           Icolor: Color(0xFFD98F39),
                                           Tcolor: Color(0xFFA26823),
                                           I_size:  60.0,
                                           icon: FontAwesomeIcons.creditCard,
                                           I_padding: const EdgeInsets.only(top: 15.0),
                                           text: "Pay Bills",
                                         ),
                                       ],
                                     ),
                                     SizedBox(width: 5.0,),
                                     ListViewContainers(
                                       padding: const EdgeInsets.only(top: 125.0),
                                       c_height: 245.0,
                                       Ccolor: Color(0xFFC99BFF),
                                       Icolor: Color(0xFF7C27E0),
                                       Tcolor: Color(0xFF7C27E0),
                                       I_size:  40.0,
                                       icon: FontAwesomeIcons.simCard,
                                       I_padding: const EdgeInsets.only(top: 15.0),
                                       text: "Airtime & Mobile\nTopup",
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(width: 5.0,),
                           Column(
                             children: <Widget>[
                               ListViewContainers(
                                 padding: const EdgeInsets.only(top: 70.0),
                                 c_height: 245.0,
                                 Ccolor: Color(0xFFD3F1FF),
                                 Icolor: Color(0xFF22ADEF),
                                 Tcolor: Color(0xFF22ADEF),
                                 I_size:  100.0,
                                 icon: FontAwesomeIcons.dollarSign,
                                 I_padding: const EdgeInsets.only(top: 15.0, left: 60.0),
                                 text: "Foreign Currency\nTransfer",
                               ),
                               SizedBox(height: 5.0,),
                               ListViewContainers(
                                 padding: const EdgeInsets.only(top: 0.0),
                                 c_height: 120.0,
                                 Ccolor: Color(0xFFFF8997),
                                 Icolor: Color(0xFFD04454),
                                 Tcolor: Colors.white,
                                 I_size:  40.0,
                                 icon: FontAwesomeIcons.moneyBillWave,
                                 I_padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                                 text: "Click Credit",
                               ),
                             ],
                           ),
                           SizedBox(width: 5.0,),
                           Padding(
                             padding: const EdgeInsets.only(right: 15.0),
                             child: Column(
                               children: <Widget>[
                                 ListViewContainers(
                                   padding: const EdgeInsets.only(top: 30.0),
                                   c_height: 245.0,
                                   Ccolor: Color(0xFFFFBE72),
                                   Icolor: Color(0xFFE3A55D),
                                   Tcolor: Colors.white,
                                   I_size:  100.0,
                                   icon: FontAwesomeIcons.solidLightbulb,
                                   I_padding: const EdgeInsets.only(top: 15.0, left: 30.0),
                                   text: "Electricity",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListViewContainers extends StatelessWidget {
  const ListViewContainers({
    Key key, this.Tcolor, this.Ccolor, this.Icolor, this.c_height, this.I_size, this.padding, this.icon, this.I_padding, this.text, this.onTap,
  }) : super(key: key);

  final Color Tcolor, Ccolor, Icolor;
  final double c_height, I_size;
  final EdgeInsets padding, I_padding;
  final IconData icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: c_height,
        width: 165.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Ccolor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: I_padding,
                child: Icon(
                  icon,
                  color: Icolor,
                  size: I_size,
                ),
              ),
              Padding(
                padding: padding,
                child: Text(text,
                  style: TextStyle(
                    color: Tcolor,
                    fontWeight: FontWeight.bold,
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
