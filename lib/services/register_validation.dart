import 'package:flutter/material.dart';
import 'package:quiz_app/services/models.dart';

class RegisterValidation with ChangeNotifier {
  // login field items
  ValidationItem _email = ValidationItem("", null);
  ValidationItem _name = ValidationItem("", null);
  ValidationItem _password = ValidationItem("", null);

  //getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get name => _name;
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

  void setName(String name) {
    if (name.length > 5) {
      _name = ValidationItem(name, null);
    } else {
      _name = ValidationItem("", "Too short. Must have atleast 5 characters");
    }
    notifyListeners();
  }

// local validation
  bool isValid() {
    if ((_email.error == null &&
            _password.error == null &&
            _name.error == null) &&
        (_email.value != "" && _password.value != "" && _name.value != "")) {
      return true;
    } else {
      return false;
    }
  }

// private functions
  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
