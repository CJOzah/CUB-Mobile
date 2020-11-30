import 'package:cub_mobile/database_users.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/sign_up_folder/open_account_screen2.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_validation/form_validation.dart';
import 'package:provider/provider.dart' hide BuildContext;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class OpenAccountScreen extends StatefulWidget {
  static String id = 'OpenAccountScreen';

  @override
  _OpenAccountScreenState createState() => _OpenAccountScreenState();
}

class _OpenAccountScreenState extends State<OpenAccountScreen> {
  String phoneNumber, dob, bvn, referral;
  Color dobColor = dividerColor;
  Color bvnColor = dividerColor;
  Color referralColor = dividerColor;

  TextEditingController _controller;
  var dobController = TextEditingController();
  final GlobalKey<FormState> _form1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _form2Key = GlobalKey<FormState>();

  static final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Padding(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: FormProgressIndicator(
                    page: [true, false, false],
                    color2: dividerColor,
                    color1: dividerColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, right: 12.0, bottom: 12.0),
                  child: Text(
                    "Please enter your phone number the press next",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                Form(
                  // key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "i Tap to select mobile country code",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: dividerColor,
                        ),
                      ),
                      Form(
                        key: _form1Key,
                        child: TextFieldWithCountryCode(
                          controller: _controller,
                          icon: Icons.perm_contact_calendar,
                          iconColor: primaryRed,
                          iconFunction: null,
                          iconSize: 23.0,
                          validate: (String value) {
                            var validator = Validator(
                              validators: [
                                RequiredValidator(),
                                PhoneNumberValidator(),
                              ],
                            );

                            return validator.validate(
                              context: context,
                              label: 'Phone Number',
                              value: value,
                            );
                          },
                          onchanged: (value) {
                            setState(() {
                              if (!_form1Key.currentState.validate()) {
                                return;
                              }
                              phoneNumber = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RoundedRectTextFieldLabel(
                      text: "Please enter your DOB",
                    ),
                    Form(
                      key: _form2Key,
                      child: RoundedRectTextField(
                        maxLength: 10,
                        controller: dobController,
                        height: 40.0,
                        hintText: "Date of birth",
                        withHint: true,
                        borderColor: dobColor,
                        textInputType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty ||
                              (value.length < 10 || value.length > 10)) {
                            return "";
                          }
                          if (!RegExp(
                              r'^(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))\-[0,1]?\d{1}\-(([0-2]?\d{1})|([3][0,1]{1}))$')
                              .hasMatch(value)) {
                            return '';
                          }
                          return null;
                        },
                        onchanged: (value) {
                          setState(() {
                            if (!_form2Key.currentState.validate()) {
                              dobColor = primaryRed;
                              return;
                            }
                            dobColor = dividerColor;
                            dob = value;
                          });
                        },
                        onTap: () => DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1800, 1, 1),
                            maxTime: DateTime(now.year, now.month, now.day),
                            theme: DatePickerTheme(
                                headerColor: primaryRed,
                                backgroundColor: Colors.white,
                                cancelStyle: TextStyle(color: Colors.white),
                                itemStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                doneStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)), onConfirm: (date) {
                          dob = "${date.year}-${date.month}-${date.day}";
                          print('confirm $dob');
                          dobController.text = dob;
                        }, currentTime: DateTime.now(), locale: LocaleType.en),
                      ),
                    ),
                    (dobColor == primaryRed)
                        ? FormErrMessage(
                            text:
                                "Date of birth must be formatted as YYYY-MM-DD",
                          )
                        : SizedBox(),
                    RoundedRectTextFieldLabel(
                      text: "Please enter your BVN (Optional)",
                    ),
                    RoundedRectTextField(
                      maxLength: 11,
                      textInputType: TextInputType.number,
                      controller: _controller,
                      height: 40.0,
                      hintText: "BVN (Optional)",
                      withHint: true,
                      borderColor: bvnColor,
                      onchanged: (String value) {
                        setState(() {
                          bvnColor = (value.toString().length < 11 )
                              ? primaryRed
                              : dividerColor;
                          if(value.isEmpty)
                            bvnColor = dividerColor;
                          bvn = value;
                        });
                      },
                    ),
                    (bvnColor == primaryRed)
                        ? FormErrMessage(
                      text:
                      "BVN must be 11 digits",
                    )
                        : SizedBox(),
                    RoundedRectTextFieldLabel(
                      text: "Please enter your referral's ID (Optional)",
                    ),
                    RoundedRectTextField(
                      maxLength: 11,
                      textInputType: TextInputType.number,
                      height: 40.0,
                      hintText: "Referral ID (optional)",
                      withHint: true,
                      borderColor: referralColor,
                      onchanged: (String value) {
                        setState(() {
                          referralColor = (value.toString().length < 11)
                              ? primaryRed
                              : dividerColor;
                          if(value.isEmpty)
                            referralColor = dividerColor;
                          referral = value;
                        });
                      },
                    ),
                    (referralColor == primaryRed)
                        ? FormErrMessage(
                      text:
                      "Referral ID must be the user's Phone Number",
                    )
                        : SizedBox(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      MoreScreenIcon(
                        icon: FontAwesomeIcons.question,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Tapables(text: "What's Referral ID?", ontap: null)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 170.0),
                  child: Column(
                    children: <Widget>[
                      RoundedRect(
                        text: "Next",
                        color: primaryRed,
                        height: 40.0,
                        onpressed: () {
                          if (!_form1Key.currentState.validate() ||
                              !_form2Key.currentState.validate()) {
                            return;
                          }
                          _form1Key.currentState.save();
                          _form2Key.currentState.save();
                          Provider.of<User>(context, listen: false)
                              .setOpenAcc1Details(
                                  dob, bvn, referral, phoneNumber);
                          Navigator.pushNamed(context, OpenAccountScreen2.id);
                        },
                      ),
                      RoundedRect(
                        text: "Cancel",
                        color: primaryRed,
                        height: 40.0,
                        onpressed: () => Navigator.pop(context),
                      ),
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
