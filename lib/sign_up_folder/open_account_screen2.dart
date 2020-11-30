import 'package:carousel_slider/carousel_slider.dart';
import 'package:cub_mobile/database_users.dart';
import 'package:cub_mobile/home_screens/image_picker.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' hide BuildContext;

import 'open_account_screen3.dart';

class OpenAccountScreen2 extends StatefulWidget {
  static String id = 'OpenAccountScreen2';

  @override
  _OpenAccountScreen2State createState() => _OpenAccountScreen2State();
}

class _OpenAccountScreen2State extends State<OpenAccountScreen2> {
  List<String> accType = ["Savings", "Current"];
  String phoneNumber, nameFirst, nameLast, addr, emailAddr;
  Color firstName = dividerColor;
  Color lastName = dividerColor;
  Color address = dividerColor;
  Color emailAddress = dividerColor;
  int textPage = 0;

  final GlobalKey<FormState> _form4Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form3Key = GlobalKey<FormState>();

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    iconButton(
                      function: () => Navigator.pop(context),
                      icon: Icons.arrow_back_sharp,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 120.0),
                      child: Center(
                        child: Text(
                          "New to Banking",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 10, bottom: 15, left: 10.0, right: 10.0),
                  child: FormProgressIndicator(
                    page: [true, true, false],
                    color1: primaryRed,
                    color2: dividerColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 10.0),
                  child: Text(
                    "Please enter the following information then press validate",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
                Container(
                  height: 130.0,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: Color(0xFFC5C5C5).withOpacity(0.32),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0)),
                            color: primaryRed,
                          ),
                          width: double.infinity,
                          child: Text(
                            "Account Type",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 5.0, top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: <Widget>[
                              RoundedIcons(
                                icon: Icons.arrow_back_ios,
                                onTap: () => buttonCarouselController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                ),
                              ),
                              SlidingText(
                                height: 40.0,
                                width: 180.0,
                                buttonCarouselController:
                                    buttonCarouselController,
                                textPage: textPage,
                                items: <Widget>[
                                  Text(
                                    accType[0],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    accType[1],
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                                onChanged: (index, reason) {
                                  setState(() {
                                    textPage = index;
                                  });
                                },
                              ),
                              RoundedIcons(
                                icon: Icons.arrow_forward_ios,
                                onTap: () =>
                                    buttonCarouselController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RoundedRectTextFieldLabel(
                      text: "Please enter your first name",
                    ),
                    Form(
                      key: _form1Key,
                      child: RoundedRectTextField(
                        maxLength: 15,
                        textInputType: TextInputType.text,
                        width: double.infinity,
                        height: 40.0,
                        hintText: "First name",
                        withHint: true,
                        borderColor: firstName,
                        validator: (String value) {
                          if (value.isEmpty || value.length >= 15) {
                            return "";
                          }
                        },
                        // onSaved: (String value){
                        //   nameFirst = value;
                        // },
                        onchanged: (value) {
                          setState(() {
                            if (!_form1Key.currentState.validate()) {
                              firstName = primaryRed;
                              return;
                            }
                            firstName = dividerColor;
                            nameFirst = value;
                          });
                        },
                      ),
                    ),
                    (firstName == primaryRed)
                        ? FormErrMessage(
                            text:
                                "Name must be more than 2 characters and lesser than 15 characters",
                          )
                        : SizedBox(),
                    RoundedRectTextFieldLabel(
                      text: "Please enter your last name",
                    ),
                    Form(
                      key: _form2Key,
                      child: RoundedRectTextField(
                        maxLength: 15,
                        width: double.infinity,
                        height: 40.0,
                        hintText: "Last name",
                        withHint: true,
                        borderColor: lastName,
                        validator: (String value) {
                          if (value.isEmpty || value.length >= 15) {
                            return "";
                          }
                        },
                        onchanged: (value) {
                          setState(() {
                            if (!_form2Key.currentState.validate()) {
                              lastName = primaryRed;
                              return;
                            }
                            lastName = dividerColor;
                            nameLast = value;
                          });
                        },
                      ),
                    ),
                    (lastName == primaryRed)
                        ? FormErrMessage(
                            text:
                                "Name must be more than 2 characters and lesser than 15 characters",
                          )
                        : SizedBox(),
                    RoundedRectTextFieldLabel(
                      text: "Please enter your email address",
                    ),
                    Form(
                      key: _form3Key,
                      child: RoundedRectTextField(
                        width: double.infinity,
                        height: 40.0,
                        hintText: "Email Address",
                        withHint: true,
                        borderColor: emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return '';
                          }

                          if (!RegExp(
                                  "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                              .hasMatch(value)) {
                            return 'Invalid format';
                          }

                          // validator has to return something :)
                          return null;
                        },
                        onchanged: (value) {
                          setState(() {
                            if (!_form3Key.currentState.validate()) {
                              emailAddress = primaryRed;
                              return;
                            }
                            emailAddress = dividerColor;
                            emailAddr = value;
                          });
                        },
                      ),
                    ),
                    (emailAddress == primaryRed)
                        ? FormErrMessage(
                            text: "Email Address is not formatted properly",
                          )
                        : SizedBox(),
                    RoundedRectTextFieldLabel(
                      text: "Please enter your address",
                    ),
                    Form(
                      key: _form4Key,
                      child: RoundedRectTextField(
                        maxLength: 30,
                        width: double.infinity,
                        height: 40.0,
                        hintText: "Address",
                        withHint: true,
                        borderColor: address,
                        validator: (String value) {
                          if (value.isEmpty || value.length >= 30) {
                            return "";
                          }
                        },
                        onchanged: (value) {
                          setState(() {
                            if (!_form4Key.currentState.validate()) {
                              address = primaryRed;
                              return;
                            }
                            address = dividerColor;
                            addr = value;
                          });
                        },
                      ),
                    ),
                    (address == primaryRed)
                        ? FormErrMessage(
                      text:
                      "Enter a valid Home Address",
                    )
                        : SizedBox(),
                  ],
                ),
                RoundedRectTextFieldLabel(
                  text: "Please add a scanned photo for your passport",
                ),
                Center(
                  child: iconButton(
                    function: () {
                      openImagePicker(context);
                    },
                    icon: Icons.camera_alt,
                    size: 45.0,
                    color: primaryRedDark,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RoundedRect(
                      text: "Validate",
                      color: primaryRed,
                      height: 40.0,
                      width: double.infinity,
                      onpressed: () {
                        if (!_form1Key.currentState.validate() ||
                            !_form2Key.currentState.validate() ||
                            !_form3Key.currentState.validate() ||
                            !_form4Key.currentState.validate()) {
                          setState(() {
                            firstName = primaryRed;
                            lastName = primaryRed;
                            address = primaryRed;
                            emailAddress = primaryRed;
                          });
                          return;
                        }
                        _form1Key.currentState.save();
                        _form2Key.currentState.save();
                        _form3Key.currentState.save();
                        _form4Key.currentState.save();
                        Provider.of<User>(context, listen: false)
                            .setOpenAcc2Details(nameFirst, nameLast, emailAddr,
                                addr, accType[textPage]);
                        Navigator.pushNamed(context, OpenAccountScreen3.id);
                      },
                    ),
                    RoundedRect(
                      text: "Cancel",
                      color: primaryRed,
                      height: 40.0,
                      width: double.infinity,
                      onpressed: () => Navigator.pop(context),
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
