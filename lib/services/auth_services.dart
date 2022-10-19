import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_app/services/helper_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/homescreen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';

enum Status { idle, busy }

class AuthService with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? _user = FirebaseAuth.instance.currentUser;
  User? get user => _user;
  Status status = Status.idle;

  // determine the screen to be loaded ....
  Widget handleAuthResponse() {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (FirebaseAuth.instance.currentUser != null) {
          return const HomeScreen(); // for sign up
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      status = Status.busy;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      status = Status.idle;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return showErrorDialog(context,
            message: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        return showErrorDialog(context, message: "Invalid password.");
      }
    } catch (e) {
      return showErrorDialog(context);
    }
    notifyListeners();
  }

  // sign up with email

  Future signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      status = Status.busy;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      status = Status.idle;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return showErrorDialog(context,
            message: "Password is too weak. Consider a stronger password.");
      } else if (e.code == 'email-already-in-use') {
        return showErrorDialog(context,
            message: "An account with this email already exists.");
      }
    } catch (e) {
      return showErrorDialog(context);
    }

    notifyListeners();
  }

  // sign in with google ...
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Once signed in, return the UserCredential
    // return

    notifyListeners();
  }

  // signout
  signOut() async {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  // ends
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///

// import 'dart:convert';
// // import 'dart:html' as http;

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:quiz_app/screens/screens.dart';

// class AuthServices with ChangeNotifier {
//   final _auth = FirebaseAuth.instance;

//   User? get user => _auth.currentUser;

//   // determine the screen to enter
//   Widget handleAuthResponse() {
//     return StreamBuilder(
//       stream: _auth.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return const HomeScreen();
//         }
//         return const LoginScreen();
//       },
//     );
//   }

// // Sign in with google
  // Future<void> signInWithGoogle() async {
  //   // Trigger the authentication flow

  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  //     // Create a new credential
  //     if (googleAuth != null &&
  //         googleAuth.accessToken != null &&
  //         googleAuth.idToken != null) {
  //       try {
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken,
  //           idToken: googleAuth.idToken,
  //         );
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //       } catch (error) {
  //         print(error.toString());
  //       }
  //     }

  //     // Once signed in, return the UserCredential
  //     // return
  //   }
  //   notifyListeners();
  // }
// // create user with email and password

//   Future<void> createUserWithEmailAndPassword(
//       String emailAddress, String password) async {
//     await _auth.createUserWithEmailAndPassword(
//       email: emailAddress,
//       password: password,
//     );

//     notifyListeners();
//   }

//   // Login with email and password

//   // login with email and password
//   Future<void> signInWithEmailAndPassword(
//       String emailAddress, String password) async {
//     await _auth.signInWithEmailAndPassword(
//       email: emailAddress,
//       password: password,
//     );

//     notifyListeners();
//   }

//   // signout
//   signOut() async {
//     ///  Check the existence
//     var methods =
//         await FirebaseAuth.instance.fetchSignInMethodsForEmail(user!.email!);
//     // if the user is logged in with google account
//     if (methods.contains('google.com')) {
//       await GoogleSignIn().signOut();
//     }
//     FirebaseAuth.instance.signOut();
//   }
//   // class ends here
// }
