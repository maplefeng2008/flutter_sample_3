import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLogin = false;
  Map _userInfo = {};

  bool get isLogin => _isLogin;
  Map get userInfo => _userInfo;

  void initUser(Map userInfo) {
    _userInfo = userInfo;
    _isLogin = true;

    notifyListeners();
  }

  void logout() {
    _userInfo = {};
    _isLogin = false;

    notifyListeners();
  }
}