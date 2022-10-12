import 'package:flutter/material.dart';

// font family manager
class FontFamily {
  static const String montserrat = "Montserrat";
}

// font weight manager
class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

// color Manager
class ColorManager {
  static const Color primary = Color(0XFF5A59D6);
  static const Color darkGrey = Color(0XFF525252);
  static const Color grey = Color(0XFF737477);
  static const Color lightGrey = Color(0XFF9E9E9E);
  static const Color white = Color(0XFFFFFFFF);
  static const Color error = Color(0XFFE61F34);
  static const Color black = Color(0XFF000000);
}

TextStyle _getTextStyle(
  String fontFamily,
  double fontSize,
  Color color,
  FontWeight fontWeight,
) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// Light Text
TextStyle getLightTextStyle({
  String fontFamily = FontFamily.montserrat,
  double size = 14,
  Color color = ColorManager.grey,
  FontWeight fontWeight = FontWeightManager.light,
}) {
  return _getTextStyle(FontFamily.montserrat, size, color, fontWeight);
}

// Regular Text Style
TextStyle getRegularTextStyle({
  String fontFamily = FontFamily.montserrat,
  double size = 16,
  Color color = ColorManager.black,
  FontWeight fontWeight = FontWeightManager.normal,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// Medium Text
TextStyle getMediumTextStyle({
  String fontFamily = FontFamily.montserrat,
  double size = 18,
  Color color = ColorManager.black,
  FontWeight fontWeight = FontWeightManager.medium,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// SemiBold Text
TextStyle getSemiBoldTextStyle({
  String fontFamily = FontFamily.montserrat,
  double size = 20,
  Color color = ColorManager.black,
  FontWeight fontWeight = FontWeightManager.medium,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}

// Bold Text
TextStyle getBoldTextStyle({
  String fontFamily = FontFamily.montserrat,
  double size = 24,
  Color color = ColorManager.black,
  FontWeight fontWeight = FontWeightManager.bold,
}) {
  return _getTextStyle(fontFamily, size, color, fontWeight);
}
