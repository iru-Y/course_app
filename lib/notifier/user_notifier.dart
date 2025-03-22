// user_notifier.dart
import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  String? _email;

  String? get email => _email;

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void clearUser() {
    _email = null;
    notifyListeners();
  }
}