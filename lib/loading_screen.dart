import 'package:cub_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_screens/home.dart';
class LoadingScreen extends StatefulWidget {

  static String id = 'LoadingScreen';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {




  Future<void> _removeLoading() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      Navigator.pop(context);
      Navigator.pushNamed(context, Home.id);
    });
  }

  @override
  void initState() {
    super.initState();
    _removeLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFB72F20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width/1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/web_hi_res_512.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
