import 'package:flutter/material.dart';

class Result {
  final Color color;
  final String title;
  final int value;
  final String? trailingSymbol;
  const Result(this.title, this.value, this.color, [this.trailingSymbol]);
}
