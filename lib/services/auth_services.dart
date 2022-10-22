import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/models/user_model.dart';
import 'package:quiz_app/services/db_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper_functions.dart';

class AuthService with ChangeNotifier {
//
  final _auth = FirebaseAuth.instance;

  // User? get user => FirebaseAuth.instance.currentUser;
  UserModel? _user;
  UserModel? get user {
    if (_user == null) {
      getUserData();
    }
    return _user;
  }

  void refresh() {
    notifyListeners();
  }

  // Automatic login and logout with shared preferences
  Future<void> setAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IS_USER_LOGGED_IN", true);
  }

  Future<void> clearAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // if (prefs.containsKey('IS_USER_LOGGED_IN')) {
    await prefs.remove("IS_USER_LOGGED_IN");
    // }
  }

  Future<bool> getAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? status = prefs.getBool('IS_USER_LOGGED_IN');
    return status != null;
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await setAuthStatus();
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

  Future signUpWithEmailAndPassword(String email, String password,
      String fullname, BuildContext context) async {
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      DatabaseService().registerUserData(firebaseUser.user!, name: fullname);
      await setAuthStatus();
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

    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn().catchError(
        (e) {
          print(" => $e");
        },
      );
      if (googleUser == null) return;

      // Obtain the auth details from the request

      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) return;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      DatabaseService().registerUserData(firebaseUser.user!);
      await setAuthStatus();
    } on PlatformException catch (e) {
      if (e.code == "sign_in_canceled") {
        print("Sign in cancelled");
      } else {
        print("Error occured");
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  // signout
  signOut() async {
    //  Check the existence of google sign in

    var methods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(user!.email!);
    if (methods.contains('google.com')) {
      await GoogleSignIn().signOut();
    }
    await FirebaseAuth.instance.signOut();
    await clearAuthStatus();
    notifyListeners();
  }

//
  // void registerUserData(User user, {String? name, String? photoUrl}) {
  //   try {
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');
  //     users.doc(user.uid).set({
  //       'name': name ?? user.displayName,
  //       'email': user.email,
  //       'photoUrl': photoUrl ?? user.photoURL,
  //       'uid': user.uid,
  //       // 'lastSeen': DateTime.now(),
  //     });
  //   } catch (e) {
  //     print("Error adding data $e");
  //   }
  // }

  Future<UserModel?> getUserData() async {
    UserModel? firebaseUser;

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(currentUser!.uid).get().then((value) {
        final response = value.data() as Map<String, dynamic>;

        firebaseUser = UserModel(
          name: response['name'],
          email: response['email'],
          imgUrl: response['photoUrl'],
          uid: response['uid'],
        );
        _user = firebaseUser;
        print(firebaseUser!.email);
        return firebaseUser;
      });
    } catch (e) {
      print("Error retriving data $e");
    }
    // print(firebaseUser!.email);
    return firebaseUser;
  }

  // ends

}
