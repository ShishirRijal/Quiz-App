import 'package:flutter/material.dart';
import 'package:quiz_app/services/services.dart';

void showErrorDialog(BuildContext context, {String? message}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text('Error!',
                  style: getMediumTextStyle(color: ColorManager.error)),
            ),
            content: Text(
              message ??
                  "An unknown errror occured.\n  Try again by checking your internet connection",
              style: getRegularTextStyle(),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok',
                      style: getRegularTextStyle(color: ColorManager.primary)))
            ],
          ));
}

// get remark
String getRemark(int score) {
  if (score >= 80) {
    return 'Excellent!! You aced it...';
  } else if (score >= 60) {
    return 'Good!! You are doing amazing...';
  } else if (score >= 40) {
    return 'Average!! You can do better...';
  } else if (score >= 20) {
    return 'Poor!! You need to work hard...';
  } else {
    return 'Very Poor!! Work hard and don\'t give up...';
  }
}
