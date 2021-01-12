import 'package:country_pickers/country_pickers.dart';
import 'package:cub_mobile/country_data.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart' hide BuildContext;

class SignUpScreen extends StatelessWidget {
  static String id = 'SignUpScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "You are signing up with your account in",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        CountryPickerUtils.getFlagImageAssetPath(
                            Provider.of<CountryData>(context).getIso()),
                        height: 15.0,
                        width: 25.0,
                        fit: BoxFit.fill,
                        package: "country_pickers",
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                          "${Provider.of<CountryData>(context).selectedCountry.name}"),
                      iconButton(function: null, icon: Icons.arrow_drop_down),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Use Activation Code",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Tapables(
                        text: "Click Here",
                        size: 20.0,
                        color: primaryRed,
                        ontap: null,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 148.0, top: 35.0),
                        child: Text(
                          "Sign up using:",
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, top: 10.0),
                        child: HorizontalLine(
                          height: 3.5,
                          width: 360.0,
                          color: primaryRed,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 12.0, bottom: 8.0),
                          child: MoreItemsBuilder(
                            icon: FontAwesomeIcons.creditCard,
                            iconSize: 20.0,
                            textColor: Colors.black,
                            iconColor: Colors.black,
                            text: "Debit Card",
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                        HorizontalLine(
                          height: 1.0,
                          width: 300.0,
                          color: dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 12.0, bottom: 6.0),
                          child: MoreItemsBuilder(
                            icon: FontAwesomeIcons.solidCreditCard,
                            iconSize: 20.0,
                            text: "Prepaid Card",
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                        HorizontalLine(
                          height: 1.0,
                          width: 300.0,
                          color: dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 12.0, bottom: 6.0),
                          child: MoreItemsBuilder(
                            icon: FontAwesomeIcons.starOfDavid,
                            iconColor: Colors.black,
                            iconSize: 20.0,
                            text: "Activate with USSD",
                            textColor: Colors.black,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                        HorizontalLine(
                          height: 1.0,
                          width: 300.0,
                          color: dividerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 12.0, bottom: 6.0),
                          child: MoreItemsBuilder(
                            icon: FontAwesomeIcons.universalAccess,
                            iconSize: 20.0,
                            text: "Account + Secure Pass",
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MoreScreenIcon(
                    icon: FontAwesomeIcons.question,
                    size: 13.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Tapables(
                    text: "What is Secure Pass?",
                    ontap: null,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Registered in Branch",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Tapables(
                      text: "Click Here",
                      size: 20.0,
                      color: primaryRed,
                      ontap: null,
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
