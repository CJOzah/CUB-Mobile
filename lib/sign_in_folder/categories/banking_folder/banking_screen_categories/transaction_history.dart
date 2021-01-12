import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../database_users.dart';

class TransactionHistory extends StatefulWidget {
  static String id = "TransactionHistory";

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<bool> onTap = List.filled(20, false, growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc("${Provider.of<User>(context).userDetails["id"]}")
              .collection("History")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new ListView(
              children: snapshot.data.docs
                  .asMap()
                  .map((key, DocumentSnapshot document) {
                    return MapEntry(
                        key,
                        (onTap[key] == false)
                            ? Column(
                                children: [
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${document["date"]}, ${document["time"]}",
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100.0),
                                                child: Text(
                                                  "CUB (${document["amount"]})",
                                                  style: TextStyle(
                                                    color: (document["type"] ==
                                                            "debit")
                                                        ? primaryRed
                                                        : Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${document["narration"]}"
                                                    .replaceRange(
                                                        20, 60, "****"),
                                                overflow: TextOverflow.clip,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              iconButton(
                                                function: () {
                                                  setState(() {
                                                    if (onTap[key] == false)
                                                      onTap[key] = true;
                                                    else {
                                                      onTap[key] = false;
                                                    }
                                                  });
                                                },
                                                icon: (onTap[key] == false)
                                                    ? Icons
                                                        .arrow_drop_up_outlined
                                                    : Icons
                                                        .arrow_drop_down_outlined,
                                                color: (document["type"] ==
                                                        "debit")
                                                    ? primaryRed
                                                    : Colors.green,
                                                size: 40.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Tap on the dropdown icon to display",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: dividerColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: HorizontalLine(
                                      color: primaryRed,
                                      height: 1.5,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Transaction Details:",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        iconButton(
                                          function: () {
                                            setState(() {
                                              if (onTap[key] == false)
                                                onTap[key] = true;
                                              else {
                                                onTap[key] = false;
                                              }
                                            });
                                          },
                                          icon: (onTap[key] == false)
                                              ? Icons.arrow_drop_up_outlined
                                              : Icons.arrow_drop_down_outlined,
                                          color: (document["type"] == "debit")
                                              ? primaryRed
                                              : Colors.green,
                                          size: 40.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HorizontalLine(
                                      height: 1.5,
                                      color: dividerColor,
                                      width: double.infinity,
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Date: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["date"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Time: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["time"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Reference: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text:
                                                  "${document["ReferenceID"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Amount: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["amount"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Status: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["status"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Type: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["type"]}",
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Accounts Details:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HorizontalLine(
                                      height: 1.5,
                                      color: dividerColor,
                                      width: double.infinity,
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Sender Name:\n ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["senderName"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "Sender Account Number:\n ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text:
                                                  "${document["senderAccountNumber"]}",
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Narration:\n ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: "${document["narration"]}",
                                            ),
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    HorizontalLine(
                                      height: 1.5,
                                      color: primaryRed,
                                      width: double.infinity,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                  ],
                                ),
                              ));
                  })
                  .values
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
