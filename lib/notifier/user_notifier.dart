// user_notifier.dart
import 'package:flutter/material.dart';
import 'package:course_app/user/user_model.dart';

class UserNotifier with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}