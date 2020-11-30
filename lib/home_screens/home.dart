import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:cub_mobile/database_users.dart';
import 'package:cub_mobile/home_screens/image_picker.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/home_screens/top_up_screen.dart';
import 'package:cub_mobile/sign_in_folder/sign_in_category.dart';
import 'package:cub_mobile/sign_up_folder/open_account_screen.dart';
import 'package:cub_mobile/sign_up_folder/sign_up_screen.dart';
import 'package:cub_mobile/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart' hide BuildContext;
import '../country_data.dart';
import '../main.dart';
import 'package:connectivity/connectivity.dart';
import '../utils.dart';

class Home extends StatefulWidget {

  static String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Country selectedDialogCountry =
  CountryPickerUtils.getCountryByName('Nigeria');

  bool showSpinner = false;
  bool showBottomSheet = false;

  String password;
  String email;
  Color number = dividerColor;
  Color pass = dividerColor;

  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: SpinKitFadingCircle(color: primaryRed, size: 80,),
        child: Scaffold(
          bottomSheet: (showBottomSheet == true) ? SingleChildScrollView(
            child: Container(
            padding: EdgeInsets.only(left: 18.0 ,right: 18.0),
      height: 400.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: primaryRedLight,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: iconButton(
                      function: () {setState(() {
                        showBottomSheet = false;
                      });},
                      icon: Icons.arrow_downward,
                      color: primaryRedDark,
                      size: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    "Email",
                  ),
                ),
               RoundedTextField(
                 padding: EdgeInsets.only(left: 12.0, bottom: 5.0),
                 text: myController1.text,
                 borderColor: dividerColor,
                   textInputType: TextInputType.emailAddress,
                   onchanged: (String value){
                     email = value;
                     myController1.text = email;
                   }
               ),
                (number == primaryRed)
                    ? FormErrMessage(
                  text: "No email entered or doesn't exist",
                )
                    : SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        size: 15.0,
                        color: Colors.black,
                      ),
                      Text("Password"),
                    ],
                  ),
                ),
                RoundedTextField(
                  padding: EdgeInsets.only(left: 12.0, top: 10.0),
                  textInputType: TextInputType.visiblePassword,
                  borderColor: pass,
                  password: true,
                  onchanged: (value) {
                    password = value;
                  },
                ),
                (pass == primaryRed)
                    ? FormErrMessage(
                  text: "No password entered or doesn't exist",
                )
                    : SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 205.0, top: 10.0, bottom: 25.0),
                  child: Tapables(
                    text: "Forgot Password?",
                    ontap: null,
                  ),
                ),
                RedRoundedRectButton(
                  ontap: ()  async {
                    try {

                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final result = await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          print('connected');
                          // auth.FirebaseAuth.instance
                          //     .authStateChanges()
                          //     .listen((auth.User user) async {
                          //   if (user == null) {
                          //     print('User is currently signed out!');
                          //   } else {
                          //     print('User is signed in!');
                          //     await auth.FirebaseAuth.instance.signOut();
                          //   }
                          // });
                         setState(() {
                           showSpinner = false;
                         });
                        }
                      } on SocketException catch (_) {
                        openMessageDialogue(context, SignUpMessage(text: "Ooops. No Internet Access.\n try again later", color: primaryRed, icon: Icons.close, text2: "Failed",),
                            );
                        showSpinner = false;
                      }

                      if (email == null) {
                        setState(() {
                          password = null;
                          number = primaryRed;
                          pass = dividerColor;
                        });
                      } else if (password == null)
                        setState(() {
                          pass = primaryRed;
                          number = dividerColor;
                        });
                      else if (password == null && email == null)
                        setState(() {
                          pass = primaryRed;
                          number = primaryRed;
                        });
                      else {
                        setState(() {
                          showSpinner = true;
                          showBottomSheet = false;
                        });
                        auth.UserCredential user =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(user.toString());

                        if (user != null) {
                          myController1.text = "";
                          email = null;
                          password = null;
                          pass = dividerColor;
                          number = dividerColor;
                          await FirebaseFirestore.instance.collection("users")
                              .doc(user.user.uid).get()
                              .then((value) {
                            Provider.of<User>(context, listen: false).setUserDetails(value.data());
                          });

                          setState(() {
                            showSpinner = false;
                          });

                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) =>
                              SignInCategory(),
                          ));
                        }
                      }
                    } catch (e) {
                      setState(() {
                        email = null;
                        password = null;
                        showBottomSheet = true;
                        number = primaryRed;
                        pass = primaryRed;
                        print(e);
                        showSpinner = false;
                        myController1.text = "";
                        myController2.text = "";
                       return;
                      });
                    }
                  },
                  text: "Sign in",
                  height: 42.0,
                  padding: EdgeInsets.only(bottom: 13.0),
                ),
              ],
            ),
        ],
      ),
    ),
          ) : SizedBox(),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/images.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Provider.of<CountryData>(context, listen: false).getCountryFlag(30.0, 30.0),
                                ),
                              iconButton(icon: FontAwesomeIcons.angleDown, color: Colors.white, function: (){CountryData().openCountryPickerDialog(context);},),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: iconButton(function: (){openImagePicker(context);},
                                    icon: FontAwesomeIcons.camera, color: Colors.white,),
                                ),
                                iconButton(function: (){
                                   Navigator.pushNamed(context, MoreScreen.id);
                                }, icon: Icons.more_vert, size: 35.0, color: Colors.white,)
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Bank",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                  Text(
                                    "BANK NAME",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "Quick Actions",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.simCard,
                                      ),
                                    ),
                                    onTap: () =>
                                      Navigator.pushNamed(context, TopUpScreen.id),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text("Top up",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 120),
                               child: RoundedRect(text: "Sign in", height: 42.0, width: 350, color: Colors.white, onpressed:
                                   () {setState(() {
                                     showBottomSheet = true;
                                   });},
                                 fillColor: Colors.black54,),
                             ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Tapables(text: "Open an Account", ontap: ()
                                      => Navigator.pushNamed(context, OpenAccountScreen.id),
                                      color: Colors.white,),
                                    Tapables(text: "Sign up", ontap: ()
                                      => Navigator.pushNamed(context, SignUpScreen.id),
                                      color: Colors.white,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

