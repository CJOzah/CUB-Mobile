import 'package:cub_mobile/home_screens/top_up_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen_categories/send_money_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/menu_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/lifestyle_screen.dart';
import 'package:cub_mobile/sign_in_folder/sign_in_category.dart';
import 'package:cub_mobile/size_config.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../database_users.dart';
import 'banking_screen_categories/transaction_history.dart';

class BankingScreen extends StatefulWidget {
  static String id = 'BankingScreen';

  @override
  _BankingScreenState createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void openComingSoonDialogue(BuildContext context) {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _colorTween = ColorTween(begin: primaryRedDark, end: Colors.white)
        .animate(_animationController);
    _animationController.forward();
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: primaryRedLight),
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
                              function: null,
                              icon: Icons.more_vert,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            iconButton(
                              function: null,
                              icon: Icons.share,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            iconButton(
                              function: null,
                              icon: Icons.close,
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
                      textStyle:
                          TextStyle(fontSize: 12.0, fontFamily: "Horizon"),
                      colors: [
                        Colors.white,
                        primaryRed,
                        Colors.white,
                      ],
                      textAlign: TextAlign.start,
                    ),
                    AnimatedBuilder(
                      animation: _colorTween,
                      builder: (context, child) => Padding(
                        padding:
                            const EdgeInsets.only(left: 100.0, right: 100.0),
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
                          child: Text(
                            "OK",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Tapables(
                            text: "Contact Us",
                            ontap: null,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Tapables(
                            text: "Unsubscribe",
                            ontap: null,
                            color: Colors.white,
                            size: 12.0,
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
    );
  }

  var isObscure = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              padding: EdgeInsets.only(left: SizeConfig.sW * 23, right: 0.0),
              height: 55.0,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "LOGO",
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
      floatingActionButton: FloatingActionButt(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: UserDetailCard(
                    isObscure: isObscure,
                    text:
                        "${Provider.of<User>(context, listen: false).userDetails["accountNumber"]}",
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: SizeConfig.sH * 5,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
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
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 0.0, right: 0.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      ListViewContainers(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        c_height: 120.0,
                                        Ccolor: Colors.lightBlueAccent.shade100,
                                        Icolor: Colors.blue,
                                        Tcolor: Colors.blue,
                                        I_size: 40.0,
                                        icon: Icons.compare_arrows,
                                        I_padding:
                                            const EdgeInsets.only(top: 15.0),
                                        text: "Send Money",
                                        onTap: () => Navigator.pushNamed(
                                            context, SendMoneyScreen.id),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      ListViewContainers(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        c_height: 120.0,
                                        Ccolor: Colors.redAccent.shade100,
                                        Icolor: primaryRedDark,
                                        Tcolor: Colors.white,
                                        I_size: 50.0,
                                        icon: FontAwesomeIcons.clock,
                                        I_padding: const EdgeInsets.only(
                                            bottom: 15.0, left: 45.0),
                                        text: "Transaction History",
                                        onTap: () => Navigator.pushNamed(
                                            context, TransactionHistory.id),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      ListViewContainers(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          c_height: 120.0,
                                          Ccolor: Color(0xFF60B247),
                                          Icolor: Color(0xFF459A2B),
                                          Tcolor: Colors.white,
                                          I_size: 70.0,
                                          icon: FontAwesomeIcons.tv,
                                          I_padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          text: "Tv subscriptions",
                                          onTap: () {
                                            openComingSoonDialogue(context);
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () =>
                                            Navigator.pushReplacementNamed(
                                                context, LifeStyleScreen.id),
                                        child: Container(
                                          height: 250.0,
                                          width: 165.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "images/lifestyle.jpeg"),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 190.0, left: 12.0),
                                            child: Text(
                                              "Lifestyle",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          ListViewContainers(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              c_height: 120.0,
                                              Ccolor: Color(0xFFA0E1FF),
                                              Icolor: Color(0xFF107EB1),
                                              Tcolor: Colors.white,
                                              I_size: 40.0,
                                              icon: FontAwesomeIcons.coins,
                                              I_padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              text: "Send Coin",
                                              onTap: () {
                                                openComingSoonDialogue(context);
                                              }),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          ListViewContainers(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              c_height: 120.0,
                                              Ccolor: Color(0xFFFFBE72),
                                              Icolor: Color(0xFFD98F39),
                                              Tcolor: Color(0xFFA26823),
                                              I_size: 60.0,
                                              icon: FontAwesomeIcons.creditCard,
                                              I_padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              text: "Pay Bills",
                                              onTap: () {
                                                openComingSoonDialogue(context);
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      ListViewContainers(
                                        padding:
                                            const EdgeInsets.only(top: 125.0),
                                        c_height: 245.0,
                                        Ccolor: Color(0xFFC99BFF),
                                        Icolor: Color(0xFF7C27E0),
                                        Tcolor: Color(0xFF7C27E0),
                                        I_size: 40.0,
                                        icon: FontAwesomeIcons.simCard,
                                        I_padding:
                                            const EdgeInsets.only(top: 15.0),
                                        text: "Airtime & Mobile\nTopup",
                                        onTap: () => Navigator.pushNamed(
                                            context, TopUpScreen.id),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              children: <Widget>[
                                ListViewContainers(
                                    padding: const EdgeInsets.only(top: 70.0),
                                    c_height: 245.0,
                                    Ccolor: Color(0xFFD3F1FF),
                                    Icolor: Color(0xFF22ADEF),
                                    Tcolor: Color(0xFF22ADEF),
                                    I_size: 100.0,
                                    icon: FontAwesomeIcons.dollarSign,
                                    I_padding: const EdgeInsets.only(
                                        top: 15.0, left: 60.0),
                                    text: "Foreign Currency\nTransfer",
                                    onTap: () {
                                      openComingSoonDialogue(context);
                                    }),
                                SizedBox(
                                  height: 5.0,
                                ),
                                ListViewContainers(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    c_height: 120.0,
                                    Ccolor: Color(0xFFFF8997),
                                    Icolor: Color(0xFFD04454),
                                    Tcolor: Colors.white,
                                    I_size: 40.0,
                                    icon: FontAwesomeIcons.moneyBillWave,
                                    I_padding: const EdgeInsets.only(
                                        bottom: 20.0, left: 20.0),
                                    text: "Click Credit",
                                    onTap: () {
                                      openComingSoonDialogue(context);
                                    }),
                              ],
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
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
                                      I_size: 100.0,
                                      icon: FontAwesomeIcons.solidLightbulb,
                                      I_padding: const EdgeInsets.only(
                                          top: 15.0, left: 30.0),
                                      text: "Electricity",
                                      onTap: () {
                                        openComingSoonDialogue(context);
                                      }),
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
    Key key,
    this.Tcolor,
    this.Ccolor,
    this.Icolor,
    this.c_height,
    this.I_size,
    this.padding,
    this.icon,
    this.I_padding,
    this.text,
    this.onTap,
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
                child: Text(
                  text,
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
