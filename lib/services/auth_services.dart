import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_app/services/helper_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/homescreen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';

enum Status { idle, busy }

class AuthService with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) => saveUserDetails());
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
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> saveUserDetails() async {
    //save user details
    User? user = FirebaseAuth.instance.currentUser;

    await _db.collection("users").doc(user?.uid).set({
      'name': 'Shishir Rijal1',
      'email': 'ccrrizatl7438@gmail.com',
    }).catchError((error) => print("Failed"));
  }

  // ends

}
