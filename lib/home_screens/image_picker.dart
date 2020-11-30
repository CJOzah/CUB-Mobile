

import 'dart:io';

import 'package:cub_mobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {

  File _image;
  final picker = ImagePicker();

  imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  imgFromGallery() async {
    final pickedFile = await  picker.getImage(
        source: ImageSource.gallery
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
          child: Card(
            elevation: 10.0,
            child: Container(
              height: 300.0,
              width: 250.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 200.0),
                      child: iconButton(function: () => Navigator.pop(context), icon: Icons.close, color: Colors.black, size: 30,),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Background Picture",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 110.0, top: 8.0),
                          child: HorizontalLine(width: 110.0, height: 2.5, color: primaryRed,),
                        ),
                      ],
                    ),
                    Text(
                      "Where would you like to get\nyour background picture from?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        RoundedRect(height: 35.0, width: 180.0, color: primaryRed, onpressed: imgFromCamera, fillColor: Colors.white, text: "Camera",),
                        RoundedRect(height: 35.0, width: 180.0, color: primaryRed, onpressed: imgFromGallery, fillColor: Colors.white, text: "Gallery",),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            color: Colors.white,
          ),
        ))
      ],
    );
  }
}


void openImagePicker(BuildContext context) =>
    showDialog(
      context: context,
      builder: (context) =>
          Container(
            color: Colors.white.withOpacity(0.70),
            child: Theme(
              data: Theme.of(context).copyWith(
                  primaryColor: primaryRedDark),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImagePick(),
                ],
              ),
            ),
          ),
    );