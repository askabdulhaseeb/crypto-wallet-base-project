import 'package:flutter/material.dart';
import '../apis/login_api.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    getuser();
  }
  AppUser? _user;
  AppUser get currentUser => _user!;
  getuser() async {
    _user = await SignInApi().get();
    notifyListeners();
  }
}
