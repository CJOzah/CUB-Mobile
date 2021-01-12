import 'dart:async';
import 'package:intl/intl.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'transfer_success_dialogue.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../../../database_users.dart';

class SendMoneyScreen extends StatefulWidget {
  static String id = "SendMoneyScreen";

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  String amount;
  String accountNumber, name;
  bool confirm = false;
  var _myController1 = TextEditingController();
  var _myController2 = TextEditingController();
  var _myController3 = TextEditingController();
  bool showSpinner = false;

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  openInsufficientFundsDialogue(accBal
      ) =>
      showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(
              primaryColor: primaryRedDark),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: <Widget>[
      //     Column(
      //     children: [
      //     Card(
      //     margin: EdgeInsets.only(left: 60.0, right: 60.0),
      //     elevation: 10.0,
      //     child: Container(
      //       height: 300.0,
      //       width: double.infinity,
      //       child: Padding(
      //         padding: const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: <Widget>[
      //             Padding(
      //               padding: const EdgeInsets.only(left: 230.0),
      //               child: iconButton(function: () => Navigator.pop(context), icon: Icons.close, color: Colors.black, size: 30,),
      //             ),
      //             Text(
      //               "No enough balance?",
      //               style: TextStyle(
      //                 fontSize: 22.0,
      //               ),
      //             ),
      //             HorizontalLine(color: primaryRed, height: 2.0, width: 115.0,),
      //             SizedBox(height: 5.0,),
      //             Text(
      //                 "You have Insufficient balance in the selected amount. to  proceed. You need NGN $amount in your account."
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(bottom: 28.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   Text(
      //                     "Bank account: $accountNumber",
      //                   ),
      //                   Text(
      //                     "Balance: $accBal",
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      //               child: RoundedRect(
      //                 height: 40.0,
      //                 width: double.infinity,
      //                 color: primaryRed,
      //                 fillColor: Colors.white,
      //                 text: "Re-check Balance",
      //                 onpressed: () => Navigator.pop(context),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     color: Colors.white,
      //   )
      //   ],
      // ),
              TransferInsufficientFunds(
                // amount: amount,
                // accountNumber: accountNumber,
                accBal: accBal,
              ),
            ],
          ),
        ),
      );


  Color borderColor = dividerColor;
  final GlobalKey<FormState> _form1Key = GlobalKey<FormState>();

  final _firestoreInstance =
      FirebaseFirestore.instance;

  Future transferCash(Map<String, dynamic> userDetails, int amt) async {
    Map<String, dynamic> adminFiles;
    await FirebaseFirestore.instance
        .collection("admin")
        .doc("20000124")
        .get()
        .then((value) {
      adminFiles = value.data();
    });

    String receiverID =
    adminFiles["$accountNumber"]["id"];
    String userID = userDetails["id"];

    Map<String, dynamic> receiverDetails;
    await FirebaseFirestore.instance
        .collection("users")
        .doc("$receiverID")
        .get()
        .then((value) {
      receiverDetails = value.data();
    });

    int userBal = userDetails["accBal"];
    int receiverBal = receiverDetails["accBal"];


    if (userDetails["accBal"] < amt) {
      print("Invalid Transaction");
      openInsufficientFundsDialogue(userDetails["accBal"]);
    } else {

      var u_uid = Uuid();
      String uuid = u_uid.v1();

      receiverBal = receiverBal + amt;
      userBal = userBal - amt;

      try {
        await _firestoreInstance
            .collection("admin")
            .doc("20000124")
            .set(
          {
            userDetails["accountNumber"]: {
              "accBal": userBal,
            },
          },
          SetOptions(merge: true),
        );
        await _firestoreInstance
            .collection("admin")
            .doc("20000124")
            .set(
          {
            accountNumber: {
              "accBal": receiverBal,
            },
          },
          SetOptions(merge: true),
        );

        await _firestoreInstance
            .collection("users")
            .doc("$userID").collection("History").doc("$uuid")
            .set(
          {
              "date": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
              "time": "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
              "ReferenceID": "$uuid",
              "amount": "$amt",
              "status": "SUCCESSFUL",
              "type": "debit",
              "senderName": "${userDetails["firstName"]} ${userDetails["lastName"]}",
              "senderAccountNumber": "${userDetails["accountNumber"]}",
               "narration": "CUB/TNF/$uuid/${userDetails["accountNumber"]}/$accountNumber",
              "token":  "${receiverDetails["token"]}",
          },
          SetOptions(merge: true),
        );

        await _firestoreInstance
            .collection("users")
            .doc("$receiverID").collection("History").doc("$uuid")
            .set(
          {
            "date": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
            "time": "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
            "ReferenceID": "$uuid}",
            "amount": "$amt",
            "status": "SUCCESSFUL",
            "type": "credit",
            "senderName": "${userDetails["firstName"]} ${userDetails["lastName"]}",
            "senderAccountNumber": "${userDetails["accountNumber"]}",
            "narration": "CUB/TNF/$uuid/${userDetails["accountNumber"]}/$accountNumber",
            "token":  "${receiverDetails["token"]}",
          },
          SetOptions(merge: true),
        );

        await _firestoreInstance
            .collection("users")
            .doc("$userID")
            .update(
          {
            "accBal": userBal,
          },
        );
        await _firestoreInstance
            .collection("users")
            .doc("$receiverID")
            .update(
          {
            "accBal": receiverBal,
          },
        );
      } catch (e) {
        print(e);
      }
      print("Transfer was Successful");
      return "Transfer was Successful";
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
                text:
                    "${Provider.of<User>(context, listen: false).userDetails["accountNumber"]}",
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

              (accountNumber == null)
                  ? FormErrMessage(
                text:
                "Enter Account Number",
              ) : SizedBox(),

              Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: TextFieldSendMoney(
                  hintText: "Account Name",
                  myController: _myController2,
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),

              (name == null)
                  ? FormErrMessage(
                text:
                "Enter Account Name",
              ) : SizedBox(),

          Padding(
            padding: const EdgeInsets.only(top: 15.0,),
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    style: BorderStyle.solid, width: 1.0, color: borderColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Form(
                key: _form1Key,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Amount",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10.0, bottom: 2.0),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  controller: _myController3,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return "";
                    }
                    if(!RegExp("^[0-9]{1,6}\$").hasMatch(value)){
                      return "";
                    }

                    // validator has to return something :)
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if(!_form1Key.currentState.validate() ){
                        borderColor = primaryRed;
                        return;
                      }
                      borderColor = dividerColor;
                    });
                    amount = value.toString();
                  },
                ),
              ),
            ),
          ),
          (borderColor == primaryRed)
              ? FormErrMessage(
            text:
            "Enter a valid Amount",
          )
              : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoneyBoxes(
                        text: "500",
                        onTap: () {
                          amount = "500";
                          _myController3.text = "500";
                        }),
                    MoneyBoxes(
                        text: "1000",
                        onTap: () {
                          amount = "1000";
                          _myController3.text = "1000";
                        }),
                    MoneyBoxes(
                        text: "2000",
                        onTap: () {
                          amount = "2000";
                          _myController3.text = "2000";
                        }),
                    MoneyBoxes(
                        text: "5000",
                        onTap: () {
                          amount = "5000";
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
                    if(!_form1Key.currentState.validate() ){
                     setState(() {
                       borderColor = primaryRed;
                     });
                      return;
                    }

                    if(accountNumber == "" || accountNumber == null){
                      setState(() {
                        accountNumber = null;
                      });
                      return;
                    }
                    print(accountNumber);

                    if(name == "" || name == null){
                      setState(() {
                        name = null;
                      });
                      return;
                    }

                    setState(() {
                      borderColor = dividerColor;
                      _form1Key.currentState.save();
                    });
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
                              'Enter your 5 digit Pin',
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
                            isValidCallback: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Theme(
                                      data: Theme.of(context).copyWith(
                                          primaryColor: primaryRedDark),
                                      child: ModalProgressHUD(
                                        inAsyncCall: showSpinner,
                                        progressIndicator: CircularProgressIndicator(value: 5.0, backgroundColor: primaryRedLight,),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Card(
                                              margin: EdgeInsets.only(left: 60.0, right: 60.0),
                                              elevation: 10.0,
                                              child: Container(
                                                height: 260.0,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 220.0),
                                                        child: iconButton(function: () => Navigator.pop(context), icon: Icons.close, color: Colors.black, size: 30,),
                                                      ),
                                                      Text(
                                                        "Are you sure?",
                                                        style: TextStyle(
                                                          fontSize: 22.0,
                                                        ),
                                                      ),
                                                      HorizontalLine(color: primaryRed, height: 2.0, width: 115.0,),
                                                      SizedBox(height: 5.0,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 28.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "Transaction Amount: $amount",
                                                            ),
                                                            Text(
                                                              "Total Fees: 10.5",
                                                            ),
                                                            Text(
                                                              "Total Amount: ",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                                        child: RoundedRect(
                                                          height: 40.0,
                                                          width: double.infinity,
                                                          color: primaryRed,
                                                          fillColor: Colors.white,
                                                          text: "OK",
                                                          onpressed: () async {
                                                            setState(() {
                                                              showSpinner = true;
                                                            });
                                                            // Navigator.pop(context);


                                                            await transferCash(Provider.of<User>(context, listen: false)
                                                                .userDetails, int.parse(amount));

                                                            setState(() {
                                                              // showSpinner = false;
                                                              accountNumber = "";
                                                              _myController3.clear();
                                                              _myController2.clear();
                                                              _myController1.clear();
                                                            });
                                                            Navigator.push(context, MaterialPageRoute(builder:
                                                            (context) => TransferSuccessDialogue(amount: amount, name: name,)
                                                            ));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                            },
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
            height: 200.0,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
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
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 20.0),
                  child: Text(
                    "${Provider.of<User>(context).userDetails["firstName"]} ${Provider.of<User>(context).userDetails["lastName"]}",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Text(
                          "${Provider.of<User>(context, listen: false).userDetails["accType"]} Account:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 90.0),
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
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(
                          "${Provider.of<User>(context, listen: false).userDetails["id"]}")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    NumberFormat format = NumberFormat('#,###,###.00');
                    if (!snapshot.hasData) return new Text('Loading...');
                    return Padding(
                      padding: const EdgeInsets.only(top: 98.0, left: 20.0),
                      child: Text(
                        "₦${format.format(int.parse(snapshot.data["accBal"]))}",
                        style: TextStyle(
                          fontSize: 35.0,
                        ),
                      ),
                    );
                  },
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

class TransferInsufficientFunds extends StatelessWidget {
  final String accBal;
  final String amount;
  final String accountNumber;

  const TransferInsufficientFunds({
    Key key,
    this.accBal,
    this.accountNumber,
    this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(left: 60.0, right: 60.0),
          elevation: 10.0,
          child: Container(
            height: 300.0,
            width: double.infinity,
            child: Padding(
              padding:
              const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 230.0),
                    child: iconButton(
                      function: () => Navigator.pop(context),
                      icon: Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  Text(
                    "No enough balance?",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  HorizontalLine(
                    color: primaryRed,
                    height: 2.0,
                    width: 115.0,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                      "You have Insufficient balance in the selected amount. to  proceed. You need NGN $amount in your account."),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bank account: $accountNumber",
                        ),
                        Text(
                          "Balance: $accBal",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: RoundedRect(
                      height: 40.0,
                      width: double.infinity,
                      color: primaryRed,
                      fillColor: Colors.white,
                      text: "Re-check Balance",
                      onpressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          color: Colors.white,
        )
      ],
    );
  }
}