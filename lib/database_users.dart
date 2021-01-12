import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  String id;
  String accountNumber;
  String email;
  String firstName;
  String lastName;
  String mobileNumber;
  String bvn;
  String dob;
  String address;
  String pin;
  String password;
  String accType;
  String accBal;

  Map<String, dynamic> userDetails;

  User({this.accountNumber, this.dob, this.address, this.pin,this.accBal, this.password, this.accType, this.id, this.email, this.lastName, this.firstName, this.mobileNumber, this.bvn});

  void setOpenAcc1Details(String dob, bvn, refId, mobileNumber){
    this.mobileNumber = mobileNumber;
    this.dob = dob;
    this.bvn = bvn;
    notifyListeners();
  }

  void setOpenAcc2Details(String firstName, String lastName, email, address, String accType){
    this.accType = accType;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.address = address;
    notifyListeners();
  }

  void setOpenAcc3Details(String pin, password, accountNumber){
    this.pin = pin;
    this.password = password;
    this.accountNumber = accountNumber;
    notifyListeners();
  }

  void setUserID(String id){
    this.id = id;
    notifyListeners();
  }
  void clearUser(){
    userDetails.clear();
    notifyListeners();
  }
  String getUserID() {
    return id;
  }

  void setUserDetails(Map<String, dynamic> userDetail){
    userDetails = userDetail;
  }
  Map<String, dynamic> getUserDetails(){
    return userDetails;
  }
}
