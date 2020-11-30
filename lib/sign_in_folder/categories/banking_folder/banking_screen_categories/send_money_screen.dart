import 'dart:async';
import 'dart:math';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../../database_users.dart';

class SendMoneyScreen extends StatefulWidget {
  static String id = "SendMoneyScreen";

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  // _showLockScreen(BuildContext context,
  //     {bool opaque,
  //       CircleUIConfig circleUIConfig,
  //       KeyboardUIConfig keyboardUIConfig,
  //       Widget cancelButton,
  //       List<String> digits}) {
  //
  // }
  //

  String _amount, accountNumber, name;
  var _myController1 = TextEditingController();
  var _myController2 = TextEditingController();
  var _myController3 = TextEditingController();
  bool showSpinner = false;
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isObscure = true;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: primaryRedLight,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryRed,
          title: Text(
            "Send Money",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Transfer from:",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              UserDetailCard(
                isObscure: isObscure = true,
                text: "${Provider.of<User>(context, listen: false).userDetails["accountNumber"]}",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Transfer to:",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFieldSendMoney(
                  hintText: "Account Number",
                  myController: _myController1,
                  onChanged: (value) async {
                    accountNumber = value;
                    if (accountNumber.length == 10) {
                      setState(() {
                        showSpinner = true;
                      });
                      bool acc = false;
                      Map<String, dynamic> adminFiles;
                      await FirebaseFirestore.instance
                          .collection("admin")
                          .doc("20000124")
                          .get()
                          .then((value) {
                        adminFiles = value.data();
                      });

                      adminFiles.forEach((key, value) {
                        if (accountNumber == key) {
                          name = value["firstName"] + " " + value["lastName"];
                          _myController2.text = name;
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFieldSendMoney(
                  hintText: "Beneficiary's Name",
                  myController: _myController2,
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFieldSendMoney(
                  hintText: "Amount",
                  myController: _myController3,
                  onChanged: (value) {
                    _amount = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoneyBoxes(
                        text: "500",
                        onTap: () {
                          _amount = "100";
                          _myController3.text = "500";
                        }),
                    MoneyBoxes(
                        text: "1000",
                        onTap: () {
                          _amount = "100";
                          _myController3.text = "1000";
                        }),
                    MoneyBoxes(
                        text: "2000",
                        onTap: () {
                          _amount = "100";
                          _myController3.text = "2000";
                        }),
                    MoneyBoxes(
                        text: "5000",
                        onTap: () {
                          _amount = "100";
                          _myController3.text = "5000";
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Charge: 10",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                child: InkWell(
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryRedLight,
                          primaryRed,
                          primaryRedDark,
                          Color(0xFF870000),
                          Color(0xFF720000)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                        child: Tapables(text: "Next", color: Colors.white)),
                  ),
                  onTap: () {
                    setState(() {
                      showSpinner = true;
                      _myController3.clear();
                      _myController2.clear();
                      _myController1.clear();
                      _amount = "";
                      accountNumber = "";
                      name = "";
                    });
                    // _showLockScreen(context,
                    //     opaque: false,
                    //     circleUIConfig: CircleUIConfig(borderColor: Colors.blue,
                    //         fillColor: Colors.blue,
                    //         circleSize: 30),
                    //     keyboardUIConfig: KeyboardUIConfig(
                    //         digitBorderWidth: 2, primaryColor: Colors.blue),
                    //     cancelButton: Icon(
                    //       Icons.arrow_back,
                    //       color: Colors.blue,
                    //     ),
                    //     digits: ['一', '二', '三', '四', '五', '六', '七', '八', '九', '零']);
                    // ignore: close_sinks

                    _onPasscodeEntered(String enteredPasscode) {
                      bool isValid = Provider.of<User>(context, listen: false)
                              .userDetails["pin"] ==
                          enteredPasscode;
                      _verificationNotifier.add(isValid);
                    }

                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(primaryColor: primaryRedDark),
                          child: PasscodeScreen(
                            title: Text(
                              'Enter your Pin',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 28),
                            ),
                            circleUIConfig: CircleUIConfig(
                                borderColor: primaryRed,
                                fillColor: primaryRed,
                                circleSize: 20),
                            keyboardUIConfig: KeyboardUIConfig(
                                digitTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                                digitBorderWidth: 2,
                                primaryColor: primaryRed),
                            passwordEnteredCallback: _onPasscodeEntered,
                            cancelButton: iconButton(
                              icon: Icons.arrow_back,
                              color: primaryRed,
                              function: () => Navigator.pop(context),
                            ),
                            deleteButton: Text(
                              'Delete',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              semanticsLabel: 'Delete',
                            ),
                            shouldTriggerVerification:
                                _verificationNotifier.stream,
                            backgroundColor: Colors.white.withOpacity(0.85),
                            cancelCallback: () {},
                            digits: [
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '0'
                            ],
                            passwordDigits: 5,
                            // bottomWidget: null,
                          ),
                        ),
                      ),
                    );
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetailCard extends StatefulWidget {
  UserDetailCard({
    Key key,
    @required this.isObscure,
    @required String text,
  })  : _text = text,
        super(key: key);

  final bool isObscure;
  final String _text;

  @override
  _UserDetailCardState createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: Card(
        semanticContainer: true,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/card.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${Provider.of<User>(context).userDetails["firstName"]} ${Provider.of<User>(context).userDetails["lastName"]}",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 85.0, left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          "${Provider.git push origin masterof<User>(context, listen: false).userDetails["accType"]} Account:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70.0),
                        child: Text(
                          (widget.isObscure != true)
                              ? widget._text
                              : '${widget._text.replaceRange(0, 6, "****")}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoneyBoxes extends StatelessWidget {
  const MoneyBoxes({
    Key key,
    this.text,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35.0,
        width: 65.0,
        decoration: BoxDecoration(
          color: Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldSendMoney extends StatelessWidget {
  TextFieldSendMoney({
    @required this.myController,
    @required this.onChanged,
    this.hintText,
  });

  final TextEditingController myController;
  final Function onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
            style: BorderStyle.solid, width: 1.0, color: dividerColor),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        controller: myController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.only(left: 10.0, bottom: 2.0),
          hintStyle: TextStyle(
            fontSize: 15.0,
          ),
        ),
        keyboardType: TextInputType.phone,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
