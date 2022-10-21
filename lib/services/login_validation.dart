import 'package:flutter/material.dart';
import 'package:quiz_app/services/models.dart';

class LoginValidation with ChangeNotifier {
  // login field items
  ValidationItem _email = ValidationItem("", null);
  ValidationItem _password = ValidationItem("", null);

  //getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;

  // setters

  void setEmail(String email) {
    // validate email...
    if (_isEmailValid(email)) {
      _email = ValidationItem(email, null);
    } else {
      _email = ValidationItem("", "Invalid email");
    }
    notifyListeners();
  }

  void setPassword(String password) {
    if (password.length >= 8) {
      _password = ValidationItem(password, null);
    } else {
      _password = ValidationItem("", "Must have atleast 8 characters");
    }
    notifyListeners();
  }

// check the validation
  bool isValid() {
    if ((_email.error == null && _password.error == null) &&
        (_email.value != "" && _password.value != "")) {
      return true;
    } else {
      return false;
    }
  }

// for forget password
  void submit() {
    // search in database and if found send the reset mail..
  }

// private functions
  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // is email valid
  bool isEmailValid() {
    return _email.error == null;
  }
}
