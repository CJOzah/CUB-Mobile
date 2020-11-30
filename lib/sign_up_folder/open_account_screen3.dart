import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cub_mobile/database_users.dart';
import 'package:cub_mobile/home_screens/home.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart' hide BuildContext;
class OpenAccountScreen3 extends StatefulWidget {

  static String id = 'OpenAccountScreen3';

  @override
  _OpenAccountScreen3State createState() => _OpenAccountScreen3State();
}

class _OpenAccountScreen3State extends State<OpenAccountScreen3> {

  String phoneNumber, pinn, password, reEnteredPin, reEnteredPass;
  Color pin = dividerColor;
  Color pass = dividerColor;
  Color pinReEntered = dividerColor;
  Color reEnteredPassword = dividerColor;
  bool showSpinner = false;
  String accountNum;

  final GlobalKey<FormState> _form1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form3Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form4Key = GlobalKey<FormState>();


  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  Future signUpWithEmail({
    @required String accountNumber,
    @required String firstName,
    @required String lastName,
    @required String bvn,
    @required String dob,
    @required String email,
    @required String address,
    @required String pin,
    @required String password,
    @required String accType,
    @required String accBal,
    @required mobileNumber
  }) async {
    try {
      Map<String, dynamic> adminFiles;
      await FirebaseFirestore.instance.collection("admin")
          .doc("20000124").get()
          .then((value) {
        adminFiles = value.data();
      });

      var rand = new Random();
      String accountNumber =  (new List.generate(10, (_) => rand.nextInt(10))).join();

      bool acc = false;
      adminFiles.forEach((key, value) {while(acc = false){
        var rand = new Random();
        String accountNumber = (new List.generate(10, (_) => rand.nextInt(10))).join();

        if(accountNumber != key) return true; }
      });
      print(accountNumber);
      accountNum = accountNumber;


      auth.UserCredential newUser = await
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (newUser != null) {
        final _firestoreInstance = FirebaseFirestore.instance;

        try {
          await
          _firestoreInstance.collection("users").doc(newUser.user.uid).set(
              {
                "accountNumber": accountNumber,
                "id": newUser.user.uid,
                "email": newUser.user.email,
                "firstName": firstName,
                "lastName": lastName,
                "bvn": bvn,
                "dob": dob,
                "address": address,
                "pin": pin,
                "password": password,
                "accType": accType,
                "mobileNumber": mobileNumber,
                "accBal": accBal
              }
          );
          await _firestoreInstance.collection("admin").doc("20000124").set(
              {
                accountNumber :
            {
              "id": newUser.user.uid,
              "email": newUser.user.email,
              "firstName": firstName,
              "lastName": lastName,
              "bvn": bvn,
              "dob": dob,
              "address": address,
              "pin": pin,
              "password": password,
              "accType": accType,
              "mobileNumber": mobileNumber,
              "accBal": accBal
            },
          }, SetOptions(merge: true));

    } catch (e) {
    return null;
    }

      }

      Navigator.of(context).pushNamedAndRemoveUntil(Home.id, (Route<dynamic> route) => false);
      openMessageDialogue(context, SignUpMessage(text: "Account Created Successfully, Your Account Number is: $accountNumber", color: Color(0xFF71C341), icon: FontAwesomeIcons.check, text2: "Success",));


      return newUser.user != null;
    }catch (e) {
      openMessageDialogue(context, SignUpMessage(text: "Something went wrong please try again", color: primaryRed, icon: Icons.close, text2: "Failed",));
      print(e);
    }
  }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:  Padding(
          padding: const EdgeInsets.only(right: 50.0),
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
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: SpinKitFadingCircle(
          color: primaryRed,
          size: 100.0,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FormProgressIndicator(page:[ true, true, true], color1: primaryRed, color2: primaryRed,),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Set your 5 digit Mobile Banking PIN. This Pin will be"
                        "\nrequired when performing transactions and services on"
                        "\nMobile Banking",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _form1Key,
                        child: RoundedRectTextField(
                          textInputType: TextInputType.number,
                          maxLength: 5,
                          height: 40.0,
                          hintText: "Set your 5 digits PIN",
                          withHint: true,
                          borderColor: pin,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Invalid pin";
                            }
                            if(!RegExp("[0-9]+[0-9]+[0-9]+[0-9]").hasMatch(value)){
                              return 'Enter a valid pin with numbers only';
                            }

                            // validator has to return something :)
                            return null;
                          },
                          onchanged: (value){
                            setState(() {
                             if(!_form1Key.currentState.validate() ){
                               pin = primaryRed;
                               return;
                             }
                             if(value == reEnteredPin)
                               pinReEntered = dividerColor;
                             pin = dividerColor;
                             pinn = value;
                            });
                          },
                        ),
                      ),
                      (pin == primaryRed)
                          ? FormErrMessage(
                        text:
                        "Pin should be 5 numbers only",
                      )
                          : SizedBox(),
                      SizedBox(height: 12.0,),
                      Form(
                        key: _form2Key,
                        child: RoundedRectTextField(
                          maxLength: 5,
                          height: 40.0,
                          hintText: "Re-enter the 5 digit PIN",
                          withHint: true,
                          borderColor: pinReEntered,
                          validator: (String value){
                            if(value.isEmpty || value.length <= 3 ){
                              return "Invalid pin";
                            }
                          },
                          onchanged: (value){
                            setState(() {
                              if(!_form2Key.currentState.validate() ){
                                pinReEntered = primaryRed;
                                return;
                              }
                              if(pinn == value)
                                pin = dividerColor;
                              pinReEntered = dividerColor;
                              reEnteredPin = value;
                            });
                          },
                        ),
                      ),
                      (pinReEntered == primaryRed)
                          ? FormErrMessage(
                        text:
                        "Pins do not match",
                      )
                          :
                      SizedBox(height: 12.0,),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please set your password."
                          "\nThis password will be requested when entering the app",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Form(
                        key: _form3Key,
                        child: RoundedRectTextField(
                          maxLength: 15,
                          textInputType: TextInputType.visiblePassword,
                          height: 40.0,
                          hintText: "Set your Password",
                          withHint: true,
                          borderColor: pass,
                          validator: (String value){
                            if(value.isEmpty || value.length <= 6 ){
                              return "Invalid password";
                            }
                            if (!RegExp(
                                "(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#\$%^&*_-])[A-Za-z0-9~!?@#\$%^&*_-]{8,40}\$").hasMatch(value)) {
                              return 'Invalid format';
                            }

                            return null;
                           },
                          onchanged: (value){
                            setState(() {
                              if(!_form3Key.currentState.validate() ){
                                pass = primaryRed;
                                return;
                              }
                              if(reEnteredPass == value)
                                reEnteredPassword = dividerColor;
                              pass = dividerColor;
                              password = value;
                            });
                          },
                        ),
                      ),
                      (pass == primaryRed)
                          ? FormErrMessage(
                        text:
                        "password must be more than 8 characters",
                      )
                          :
                      SizedBox(height: 12.0,),
                      Form(
                        key: _form4Key,
                        child: RoundedRectTextField(
                          maxLength: 15,
                          height: 40.0,
                          hintText: "Re-enter the password",
                          withHint: true,
                          borderColor: reEnteredPassword,
                          validator: (String value){
                            if(value.isEmpty || value.length <= 6 ){
                              return "Invalid password";
                            }
                            if (!RegExp(
                                "(?=.*[0-9])(?=.*[A-Za-z])(?=.*[~!?@#\$%^&*_-])[A-Za-z0-9~!?@#\$%^&*_-]{8,40}\$").hasMatch(value)) {
                              return 'Invalid format';
                            }

                            return null;
                          },
                          onchanged: (value){
                            setState(() {
                              if(!_form4Key.currentState.validate() ){
                                reEnteredPassword = primaryRed;
                                return;
                              }
                              if(password == value)
                                pass = dividerColor;
                              reEnteredPassword = dividerColor;
                              reEnteredPass = value;
                            });
                          },
                        ),
                      ),
                      (reEnteredPassword == primaryRed)
                          ? FormErrMessage(
                        text:
                        "passwords do not match",
                      )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(height: 25.0,),
                  Column(
                    children: <Widget>[
                      RoundedRect(
                        text: "Start using Mobile Banking",
                        color: primaryRed,
                        height: 40.0,
                        onpressed: () async {
                          if(!_form1Key.currentState.validate() ||
                             !_form2Key.currentState.validate() ||
                              !_form3Key.currentState.validate() ||
                              !_form4Key.currentState.validate()
                          ){
                            return;
                          }
                          if(pinn != reEnteredPin ){
                            setState(() {
                              pin = primaryRed;
                              pinReEntered = primaryRed;
                            });
                            return;
                          }
                          if(password != reEnteredPass){
                            setState(() {
                              pass = primaryRed;
                              reEnteredPassword = primaryRed;
                            });
                            return;
                          }
                          _form1Key.currentState.save();
                          _form2Key.currentState.save();
                          _form3Key.currentState.save();
                          _form4Key.currentState.save();
                          Provider.of<User>(context, listen: false).setOpenAcc3Details(pinn, password, accountNum);
                          setState(() {
                            showSpinner = true;
                            pin = dividerColor;
                            pinReEntered = dividerColor;
                            pass = dividerColor;
                            reEnteredPassword = dividerColor;
                          });
                          await signUpWithEmail(
                              firstName: Provider.of<User>(context, listen: false).firstName,
                              lastName: Provider.of<User>(context, listen: false).lastName,
                              bvn: Provider.of<User>(context, listen: false).bvn,
                              dob: Provider.of<User>(context, listen: false).dob,
                              email: Provider.of<User>(context, listen: false).email,
                              address: Provider.of<User>(context, listen: false).address,
                              pin: Provider.of<User>(context, listen: false).pin,
                              password: Provider.of<User>(context, listen: false).password,
                              mobileNumber: Provider.of<User>(context, listen: false).mobileNumber,
                              accType: Provider.of<User>(context, listen: false).accType,
                              accBal: Provider.of<User>(context, listen: false).accBal,
                              accountNumber: Provider.of<User>(context, listen: false).accountNumber
                          );
                          setState(() {
                            showSpinner = false;
                          });

                        }
                      ),
                      RoundedRect(
                        text: "Cancel",
                        color: primaryRed,
                        height: 40.0,
                        onpressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
