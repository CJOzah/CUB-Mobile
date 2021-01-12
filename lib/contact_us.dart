import 'package:cub_mobile/main.dart';
import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 25.0, left: 12.0, right: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Send us a Message",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: RoundedRectTextField(
                  borderColor: dividerColor,
                    height: 45.0,
                  hintText: "Name",
                  withHint: true,
                  textInputType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: RoundedRectTextField(
                  borderColor: dividerColor,
                  height: 45.0,
                  hintText: "Email",
                  withHint: true,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: RoundedRectTextField(
                  borderColor: dividerColor,
                  height: 45.0,
                  hintText: "Phone",
                  withHint: true,
                  textInputType: TextInputType.number,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: dividerColor,
                  ),
                ),
                margin: EdgeInsets.all(12.0),
                height: 150.0,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  cursorHeight: 25.0,
                  cursorColor: primaryRed,
                  decoration: InputDecoration(
                    enabled: true,
                    contentPadding: EdgeInsets.only(left: 5.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              RedRoundedRectButton(
                text: "Send",
                ontap: () => Navigator.pop(context),
                height: 45.0,
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
