import 'package:flutter/material.dart';

import '../services/resources/style_manger.dart';

Widget placeholderImage() {
  return Container(
    color: Colors.grey,
    child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            alignment: Alignment.center,
            height: 50.0,
            color: Colors.black38,
            child: FittedBox(
              child: Text("Upload Image",
                  style: getRegularTextStyle(color: Colors.grey)),
            ))),
  );
}
