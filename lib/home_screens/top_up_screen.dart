import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:cub_mobile/country_data.dart';
import 'package:cub_mobile/loading_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/size_config.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart' hide BuildContext;

class TopUpScreen extends StatefulWidget {
  static String id = 'TopUpScreen';

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final CarouselController buttonCarouselController = CarouselController();
  final CarouselController buttonCarouselController1 = CarouselController();

  List<String> selection = ["Buy Airtime", "Buy Data"];
  int textPage = 0;
  int textPage1 = 0;

  List<bool> nOntap = [false, false, false, false];
  List<Color> ntextColor = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];
  List<String> nSelection = [
    "MTN",
    "GLO",
    "Airtel",
    "9Mobile",
  ];

  int index = 0;
  int nIndex = 0;
  bool onTap1 = false;
  bool onTap2 = false;
  Color text1Color = Colors.black;
  Color text2Color = Colors.black;
  var _controller = TextEditingController();
  String phoneNumber, amount;

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
        title: Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(
            "Top-up",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: secondary,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DividedCard(
                  height: 120,
                  text: "Pay from",
                  items: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "Savings Account: ***5417",
                      style: TextStyle(
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                DividedCard(
                  height: 385,
                  text: "Top-up to",
                  items: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 150.0, top: 15.0),
                        child: Text(
                          "! Tap to select mobile country code",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 8.0),
                        child: TextFieldWithCountryCode(
                          controller: _controller,
                          icon: FontAwesomeIcons.timesCircle,
                          iconFunction: () => _controller.clear(),
                          iconColor: dividerColor,
                          iconSize: 20.0,
                          onchanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          validate: null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0, bottom: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RoundedIcons(
                              icon: Icons.arrow_back_ios,
                              onTap: () {
                                setState(() {
                                  buttonCarouselController1.nextPage();
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 200,
                                color: Colors.white,
                                child: CarouselSlider.builder(
                                    itemCount: selection.length,
                                    carouselController:
                                        buttonCarouselController1,
                                    options: CarouselOptions(
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.90,
                                      height: 27.0,
                                      autoPlay: false,
                                      pageSnapping: false,
                                      enlargeCenterPage: true,
                                      initialPage: textPage1,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Text(
                                        "${selection[index]}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      );
                                    }),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Container(
                                    color: Colors.white.withOpacity(0.70),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          primaryColor: primaryRedDark),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          BuildSimCategoryItems(
                                            simItems: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 290),
                                                child: iconButton(
                                                  function: () =>
                                                      Navigator.pop(context),
                                                  icon: Icons.close,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Buy Airtime",
                                                  style: TextStyle(
                                                    color: text1Color,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                trailing: onTap1
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage1 = 0;
                                                    buttonCarouselController1
                                                        .animateToPage(
                                                            textPage1);
                                                    index = 0;
                                                    onTap1 = true;
                                                    onTap2 = false;
                                                    text1Color = primaryRed;
                                                    text2Color = Colors.black;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Buy Data",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: text2Color,
                                                  ),
                                                ),
                                                trailing: onTap2
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage1 = 1;
                                                    buttonCarouselController1
                                                        .animateToPage(
                                                            textPage1);
                                                    index = 1;
                                                    onTap2 = true;
                                                    onTap1 = false;
                                                    text1Color = Colors.black;
                                                    text2Color = primaryRed;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ],
                                            height: 180.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            RoundedIcons(
                              icon: Icons.arrow_forward_ios,
                              onTap: () {
                                setState(() {
                                  buttonCarouselController1.previousPage();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            CountryPickerUtils.getFlagImageAssetPath(
                                Provider.of<CountryData>(context).getIso()),
                            height: 20.0,
                            width: 30.0,
                            fit: BoxFit.fill,
                            package: "country_pickers",
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Provider.of<CountryData>(context).getCountryName(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 22.0, right: 22.0, top: 22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RoundedIcons(
                              icon: Icons.arrow_back_ios,
                              onTap: () {
                                setState(() {
                                  buttonCarouselController.nextPage();
                                });
                              },
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 200,
                                color: Colors.white,
                                child: CarouselSlider.builder(
                                    itemCount: nSelection.length,
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.90,
                                      height: 27.0,
                                      autoPlay: false,
                                      pageSnapping: false,
                                      enlargeCenterPage: true,
                                      initialPage: textPage,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Text(
                                        "${nSelection[index]}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      );
                                    }),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Container(
                                    color: Colors.white.withOpacity(0.70),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          primaryColor: primaryRedDark),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          BuildSimCategoryItems(
                                            simItems: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 290),
                                                child: iconButton(
                                                  function: () =>
                                                      Navigator.pop(context),
                                                  icon: Icons.close,
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "MTN",
                                                  style: TextStyle(
                                                    color: ntextColor[0],
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                                trailing: nOntap[0]
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage = 0;
                                                    buttonCarouselController
                                                        .animateToPage(
                                                            textPage);
                                                    nIndex = 0;
                                                    nOntap[0] = true;
                                                    nOntap[1] = false;
                                                    nOntap[2] = false;
                                                    nOntap[3] = false;
                                                    ntextColor[0] = primaryRed;
                                                    ntextColor[1] =
                                                        Colors.black;
                                                    ntextColor[2] =
                                                        Colors.black;
                                                    ntextColor[3] =
                                                        Colors.black;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "GLO",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: ntextColor[1],
                                                  ),
                                                ),
                                                trailing: nOntap[1]
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage = 1;
                                                    buttonCarouselController
                                                        .animateToPage(
                                                            textPage);
                                                    nIndex = 1;
                                                    nOntap[1] = true;
                                                    nOntap[0] = false;
                                                    nOntap[2] = false;
                                                    nOntap[3] = false;
                                                    ntextColor[1] = primaryRed;
                                                    ntextColor[0] =
                                                        Colors.black;
                                                    ntextColor[2] =
                                                        Colors.black;
                                                    ntextColor[3] =
                                                        Colors.black;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Airtel",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: ntextColor[2],
                                                  ),
                                                ),
                                                trailing: nOntap[2]
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage = 2;
                                                    buttonCarouselController
                                                        .animateToPage(
                                                            textPage);
                                                    nIndex = 2;
                                                    nOntap[2] = true;
                                                    nOntap[1] = false;
                                                    nOntap[0] = false;
                                                    nOntap[3] = false;
                                                    ntextColor[2] = primaryRed;
                                                    ntextColor[1] =
                                                        Colors.black;
                                                    ntextColor[0] =
                                                        Colors.black;
                                                    ntextColor[3] =
                                                        Colors.black;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "9Mobile",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: ntextColor[3],
                                                  ),
                                                ),
                                                trailing: nOntap[3]
                                                    ? Icon(
                                                        Icons.done,
                                                        color: primaryRed,
                                                        size: 30.0,
                                                      )
                                                    : null,
                                                onTap: () {
                                                  setState(() {
                                                    textPage = 3;
                                                    buttonCarouselController
                                                        .animateToPage(
                                                            textPage);
                                                    nIndex = 3;
                                                    nOntap[3] = true;
                                                    nOntap[1] = false;
                                                    nOntap[2] = false;
                                                    nOntap[0] = false;
                                                    ntextColor[3] = primaryRed;
                                                    ntextColor[1] =
                                                        Colors.black;
                                                    ntextColor[2] =
                                                        Colors.black;
                                                    ntextColor[0] =
                                                        Colors.black;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ],
                                            height: 300.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            RoundedIcons(
                              icon: Icons.arrow_forward_ios,
                              onTap: () {
                                setState(() {
                                  buttonCarouselController.previousPage();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "\t\t\t\t\t\t\t\tEnter Amount \n From 10 to 50000 NGN",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 18.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RectButton(
                              icon: FontAwesomeIcons.minus,
                              ontap: null,
                            ),
                            RoundedRectTextField(
                              borderColor: dividerColor,
                              width: SizeConfig.sW * 50,
                              height: SizeConfig.sW * 11,
                              onchanged: (value) {
                                setState(() {
                                  amount = value;
                                });
                              },
                            ),
                            RectButton(
                              icon: FontAwesomeIcons.plus,
                              ontap: () {
                                setState(() {
                                  amount;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RedRoundedRectButton(
                  ontap: () => Navigator.pushNamed(context, LoadingScreen.id),
                  text: "Confirm",
                  width: 300.0,
                  height: 40.0,
                  padding: const EdgeInsets.only(bottom: 100.0, top: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
