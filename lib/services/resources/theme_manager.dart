import 'package:flutter/material.dart';
import 'package:quiz_app/services/services.dart';

ThemeData quizTheme = ThemeData(
  fontFamily: 'Montserrat',
  appBarTheme: AppBarTheme(
    backgroundColor: ColorManager.primary,
    elevation: 5.0,
    centerTitle: true,
    titleTextStyle: getMediumTextStyle(color: ColorManager.white, size: 20.0),
  ),
  scaffoldBackgroundColor: ColorManager.white,
  // text theme
  textTheme: TextTheme(
    headline1: getBoldTextStyle(size: 30.0),
    headline2: getMediumTextStyle(size: 24.0), // for titles and appbar
    //body text
    bodyText1: getRegularTextStyle(),
    bodyText2: getRegularTextStyle(color: ColorManager.grey),
    //caption text
    caption: getLightTextStyle(size: 15.0, color: ColorManager.primary),
    //button text
    button: getRegularTextStyle(color: Colors.white, size: 16.0),
  ),

  // elevated button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return ColorManager.grey;
          }
          return ColorManager.primary; // Use the component's default.
        },
      ),
      // foregroundColor: MaterialStateProperty.resolveWith<Color>(
      //   (Set<MaterialState> states) {
      //     if (states.contains(MaterialState.disabled)) {
      //       return ColorManager.black;
      //     }
      //     return ColorManager.white; // Use the component's default.
      //   },
      // ),
      alignment: Alignment.center,
      elevation: MaterialStateProperty.all(5.0),
      textStyle: MaterialStateProperty.all(
        getRegularTextStyle(color: Colors.white, size: 16.0),
      ),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50.0)),
    ),
  ),
);
