import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/quiz.dart';
import 'package:http/http.dart' as http;

import '../models/quiz_model.dart';

class DatabaseService {
  static final url = Uri.parse(
      "https://quiz-app-33f81-default-rtdb.firebaseio.com/quiz.json"); //

  ///
  Future<List<Question>> getQuestion() async {
    return http.get(url).then((response) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data.values
          .map((e) => Question(
                id: '34',
                questionText: e['questionText'],
                answers: List<String>.from(e['answers']),
                correctAnswerIndex: e['correctAnswerIndex'],
              ))
          .toList()
          .cast<Question>();
    });
  }
}
