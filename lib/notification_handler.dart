import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NotificationHandler {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void saveDeviceToken() async {
    String userID = _auth.currentUser.uid;
    //Get the token for this device
    String fcmToken = await _fcm.getToken();

    print(fcmToken);

    //Save it to Firestore
    if (fcmToken != null) {
      var tokenRef = _db
          .collection("users")
          .doc("$userID")
          .collection("tokens")
          .doc(fcmToken);

      await tokenRef.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }

  getIOSPermission() {
    _fcm.requestNotificationPermissions(
        IosNotificationSettings(alert: true, badge: true, sound: true));
    _fcm.onIosSettingsRegistered.listen((settings) {
      print("Settings registered:$settings");
      saveDeviceToken();
    });
  }

  saveTokenAndroid() {
    saveDeviceToken();
  }
}
// Replace with server token from firebase console settings.
//   final String serverToken = _db.;
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  //
  // Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
  //   await firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  //   );
  //
  //   await http.post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=$serverToken',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{
  //           'body': 'this is a body',
  //           'title': 'this is a title'
  //         },
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': '1',
  //           'status': 'done'
  //         },
  //         'to': await firebaseMessaging.getToken(),
  //       },
  //     ),
  //   );
  //
  //   final Completer<Map<String, dynamic>> completer =
  //   Completer<Map<String, dynamic>>();
  //
  //   firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       completer.complete(message);
  //     },
  //   );
  //
  //   return completer.future;
  // }
  // }
  //
  //
