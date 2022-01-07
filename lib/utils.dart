import 'package:carousel_slider/carousel_slider.dart';
import 'package:cub_mobile/country_data.dart';
import 'package:cub_mobile/message_screen.dart';
import 'package:cub_mobile/profile_screen.dart';
import 'package:cub_mobile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart' hide BuildContext;
import 'main.dart';

class iconButton extends StatelessWidget {
  final Function function;
  final IconData icon;
  final double size;
  final Color color;

  const iconButton({
    Key key,
    @required this.function,
    @required this.icon,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      onPressed: function,
    );
  }
}

class Tapables extends StatelessWidget {
  final String text;
  final Function ontap;
  final Color color;
  final double size;

  const Tapables(
      {Key key,
      @required this.text,
      @required this.ontap,
      this.color,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
        ),
      ),
      onTap: ontap,
    );
  }
}

class HorizontalLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const HorizontalLine({
    Key key,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

class RoundedRect extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final Function onpressed;
  final Color fillColor;
  final String text;

  const RoundedRect({
    Key key,
    this.color,
    this.height,
    this.width,
    @required this.onpressed,
    this.fillColor,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      fillColor: fillColor,
      onPressed: onpressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: color,
            width: 1.2,
            style: BorderStyle.solid,
          ),
        ),
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}

class RedRoundedRectButton extends StatelessWidget {
  final String text;
  final Function ontap;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  const RedRoundedRectButton({
    Key key,
    @required this.text,
    @required this.ontap,
    this.height,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: InkWell(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
                child: Tapables(
              text: text,
              color: Colors.white,
              ontap: null,
            )),
          ),
          onTap: ontap,
        ),
      ),
    );
  }
}

class RoundedTextField extends StatefulWidget {
  final Function onchanged;
  final bool password;
  Color borderColor = dividerColor;
  final TextInputType textInputType;
  final myController;
  final String text;
  final EdgeInsets padding;

  RoundedTextField({
    Key key,
    @required this.onchanged,
    this.password,
    this.myController,
    this.borderColor,
    this.textInputType,
    this.text,
    this.padding,
  }) : super(key: key);

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  final List<bool> obscuretext = [true, false];

  int index = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          style: BorderStyle.solid,
          width: 1.5,
          color: widget.borderColor = dividerColor,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 1.2,
      semanticContainer: true,
      child: Container(
        height: 45.0,
        child: TextField(
          controller: widget.myController,
          obscureText: (widget.password == true) ? obscuretext[index] : false,
          decoration: InputDecoration(
            hintText: widget.text,
            suffixIcon: (widget.password == true)
                ? iconButton(
                    function: () {
                      setState(() {
                        index++;
                        if (index == 2) index = 0;
                      });
                    },
                    icon: Icons.remove_red_eye)
                : null,
            border: InputBorder.none,
            contentPadding: widget.padding,
          ),
          keyboardType: widget.textInputType,
          cursorColor: Colors.black,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          onChanged: widget.onchanged,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FormProgressIndicator extends StatelessWidget {
  final Color color1;
  final Color color2;
  List<bool> page = [false, false, false];

  FormProgressIndicator(
      {Key key, @required this.page, this.color1, this.color2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RoundedNumber(
          text: "1",
          page: page[0],
        ),
        Container(
          height: 5.0,
          width: 125.0,
          color: color1,
        ),
        RoundedNumber(
          text: "2",
          page: page[1],
        ),
        Container(
          height: 5.0,
          width: 125.0,
          color: color2,
        ),
        RoundedNumber(
          text: "3",
          page: page[2],
        ),
      ],
    );
  }
}

class RoundedNumber extends StatelessWidget {
  final String text;
  final bool page;

  const RoundedNumber({
    Key key,
    @required this.text,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 35.0,
      decoration: BoxDecoration(
        color: (page == true) ? primaryRed : dividerColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class TextFieldWithCountryCode extends StatelessWidget {
  const TextFieldWithCountryCode({
    Key key,
    @required TextEditingController controller,
    this.icon,
    this.iconFunction,
    this.iconColor,
    this.iconSize,
    @required this.onchanged,
    @required this.validate,
    this.textInputType,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final IconData icon;
  final Function iconFunction;
  final Color iconColor;
  final double iconSize;
  final Function onchanged;
  final Function validate;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Card(
        margin: EdgeInsets.only(top: 0),
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                ),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40.0,
                child: Tapables(
                  text:
                      "${Provider.of<CountryData>(context).getIso()} +${Provider.of<CountryData>(context).getPhoneCode()}",
                  color: Colors.white,
                  ontap: () {
                    CountryData().openCountryPickerDialog(context);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 15.0, top: 5.0),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      style: BorderStyle.solid,
                      width: 0.5,
                      color: dividerColor),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)),
                ),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone number",
                    contentPadding: EdgeInsets.only(top: 10.0),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    suffixIcon: iconButton(
                      icon: icon,
                      size: iconSize,
                      color: iconColor,
                      function: iconFunction,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  onChanged: onchanged,
                  validator: validate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedRectTextField extends StatelessWidget {
  const RoundedRectTextField({
    Key key,
    this.width,
    this.onchanged,
    this.hintText,
    this.withHint,
    @required this.height,
    this.borderColor,
    this.controller,
    this.onTap,
    this.textInputType,
    this.maxLength,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final double width;
  final double height;
  final String hintText;
  final Function onchanged;
  final bool withHint;
  final Color borderColor;
  final TextEditingController controller;
  final Function onTap;
  final TextInputType textInputType;
  final int maxLength;
  final Function validator;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid, width: 0.8, color: borderColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextFormField(
          maxLength: maxLength,
          onTap: onTap,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: dividerColor),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 8.0, right: 12.0, bottom: 2.0),
          ),
          keyboardType: textInputType,
          cursorColor: Colors.black,
          textAlign: (withHint == true) ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
          validator: validator,
          onChanged: onchanged,
          onSaved: onSaved,
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Container(
              height: 32.0,
              width: 32.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/avatar.jpeg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RectButton extends StatelessWidget {
  final IconData icon;
  final Function ontap;

  const RectButton({
    Key key,
    this.icon,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      child: Container(
        height: SizeConfig.sW * 10,
        width: SizeConfig.sW * 12,
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: primaryRed,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Icon(
          icon,
          size: 8.0,
          color: primaryRed,
        ),
      ),
      onTap: ontap,
    );
  }
}

class RoundedIcons extends StatelessWidget {
  final Function onTap;
  final IconData icon;

  const RoundedIcons({
    Key key,
    @required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
              style: BorderStyle.solid, width: 0.2, color: dividerColor),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: Color(0xFFC5C5C5).withOpacity(0.32),
              blurRadius: 20.0,
            ),
          ],
        ),
        height: 30.0,
        width: 30.0,
        child: iconButton(
          function: onTap,
          icon: icon,
          size: 15.0,
          color: primaryRed,
        ));
  }
}

class DividedCard extends StatelessWidget {
  final String text;
  final Widget items;
  final double height;

  const DividedCard({
    Key key,
    @required this.text,
    @required this.items,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(left: 15.0, right: 15.0),
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 48.0,
              width: double.infinity,
              color: dividerColor.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.white,
              child: items,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSimCategoryItems extends StatelessWidget {
  List<Widget> simItems = [];
  double height;

  BuildSimCategoryItems(
      {Key key, @required this.simItems, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 8.0),
          child: Card(
            elevation: 10.0,
            child: Container(
              height: height,
              width: 340.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: simItems,
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

class RoundedRectTextFieldLabel extends StatelessWidget {
  const RoundedRectTextFieldLabel({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5, left: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
    );
  }
}

class SlidingText extends StatelessWidget {
  SlidingText({
    Key key,
    @required this.buttonCarouselController,
    @required this.textPage,
    this.items,
    this.height,
    this.width,
    @required this.onChanged,
  }) : super(key: key);

  final CarouselController buttonCarouselController;
  int textPage;
  final List<Widget> items;
  final height, width;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CarouselSlider(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
            enableInfiniteScroll: true,
            viewportFraction: 0.90,
            height: 27.0,
            autoPlay: false,
            pageSnapping: false,
            enlargeCenterPage: true,
            initialPage: textPage,
            onPageChanged: onChanged),
        items: items,
      ),
    );
  }
}

class FormErrMessage extends StatelessWidget {
  const FormErrMessage({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
          color: primaryRed,
        ),
      ),
    );
  }
}

void openMessageDialogue(BuildContext context, Widget widget) => showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: primaryRedDark),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget,
          ],
        ),
      ),
    );

class SignUpMessage extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final String text2;

  const SignUpMessage(
      {Key key,
      @required this.text,
      @required this.color,
      @required this.icon,
      @required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Container(
        height: 400,
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Card(
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.only(
                    left: 20.0, bottom: 0.0, right: 10.0, top: 40.0),
                height: 280.0,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text2,
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    FlatButton(
                      height: 50.0,
                      minWidth: 300.0,
                      color: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 280.0),
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> checkInternetConnectivity(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    openMessageDialogue(
      context,
      SignUpMessage(
        text: "Ooops. No Internet Access.\n try again later",
        color: primaryRed,
        icon: Icons.close,
        text2: "Failed",
      ),
    );
    return false;
  }
}

class FloatingActionButt extends StatelessWidget {
  const FloatingActionButt({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, right: 5.0),
      child: Container(
          height: 48.0,
          width: 48.0,
          decoration: BoxDecoration(
            color: primaryRed,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          child: iconButton(
            function: () => Navigator.pushNamed(context, MessageScreen.id),
            icon: Icons.message,
            color: Colors.white,
          )),
    );
  }
}

