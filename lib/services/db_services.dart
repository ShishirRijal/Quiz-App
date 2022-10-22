import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/services/quiz_controller.dart';
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

  // upload data to the database
  void registerUserData(User user, {String? name}) {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user.uid).set({
        'name': name ?? user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL ?? "",
        'uid': user.uid,
        // 'lastSeen': DateTime.now(),
      });
    } catch (e) {
      print("Error adding data $e");
    }
  }

  void updatePicture(String imgUrl) {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user.uid).set({
        'photoUrl': imgUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating image $e");
    }
  }
}
