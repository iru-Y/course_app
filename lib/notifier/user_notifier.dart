import 'package:course_app/user/user_model.dart';
import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {
  UserModel userModel = UserModel();

  void setEmail(String newEmail) {
     userModel ??= UserModel(); 
    userModel.email = newEmail;
    notifyListeners();
  }

   void clearUser() {
    userModel.email = null;
    notifyListeners();
  }
}
