import 'package:flutter/material.dart';
import 'package:quiz_app/services/services.dart';

void showErrorDialog(BuildContext context, {String? message}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
              child: Text('Error!',
                  style: getBoldTextStyle(color: ColorManager.error)),
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
