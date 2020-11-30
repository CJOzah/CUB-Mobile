import 'package:cub_mobile/database_users.dart';
import 'package:cub_mobile/home_screens/home.dart';
import 'package:cub_mobile/home_screens/more_screen.dart';
import 'package:cub_mobile/home_screens/top_up_screen.dart';
import 'package:cub_mobile/loading_screen.dart';
import 'package:cub_mobile/message_screen.dart';
import 'package:cub_mobile/profile_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/banking_screen_categories/send_money_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/banking_folder/menu_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/lifestyle_screen.dart';
import 'package:cub_mobile/sign_in_folder/categories/lifestyle_folder/menu_screen_lifestyle.dart';
import 'package:cub_mobile/sign_in_folder/sign_in_category.dart';
import 'package:cub_mobile/sign_up_folder/open_account_screen.dart';
import 'package:cub_mobile/sign_up_folder/open_account_screen2.dart';
import 'package:cub_mobile/sign_up_folder/open_account_screen3.dart';
import 'package:cub_mobile/sign_up_folder/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' hide BuildContext;

import 'country_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CUB());
}

const primaryRed = Color(0xFFF80000);
const primaryRedLight = Color(0xFFFFCDD2);
const primaryRedDark = Color(0xFFD32F2F);

const accentColor = Color(0xFFFF5252);
const dividerColor = Color(0xFFBDBDBD);
const secondary = Color(0xFFFFFFFF);
const secondaryColor = Colors.black;

ThemeData _appTheme(){
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryRed,
    primaryColorDark: primaryRedDark,
    primaryColorLight: primaryRedLight,
    secondaryHeaderColor: secondary,
    accentColor: accentColor,
    dividerColor: dividerColor,
    textTheme: TextTheme().copyWith(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
    ),
  );
}


class CUB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => User(),
      child: ChangeNotifierProvider(
        create: (context) => CountryData(),
        child: MaterialApp(
          initialRoute: LoadingScreen.id,
          routes: {
            Home.id: (context) => Home(),
            MoreScreen.id: (context) => MoreScreen(),
            TopUpScreen.id: (context) => TopUpScreen(),
            BankingScreen.id: (context) => BankingScreen(),
            MenuScreen.id: (context) => MenuScreen(),
            LifeStyleScreen.id: (context) => LifeStyleScreen(),
            MenuScreenLifestyle.id: (context) => MenuScreenLifestyle(),
            SignInCategory.id: (context) => SignInCategory(),
            OpenAccountScreen.id: (context) => OpenAccountScreen(),
            OpenAccountScreen2.id: (context) => OpenAccountScreen2(),
            OpenAccountScreen3.id: (context) => OpenAccountScreen3(),
            SignUpScreen.id: (context) => SignUpScreen(),
            LoadingScreen.id: (context) => LoadingScreen(),
            MessageScreen.id: (context) => MessageScreen(),
            ProfileScreen.id: (context) => ProfileScreen(),
            SendMoneyScreen.id: (context) => SendMoneyScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: _appTheme(),
        ),
      ),
    );
  }
}
