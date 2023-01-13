import 'package:ascii_image/resources/auth_methods.dart';
import 'package:ascii_image/model/user_model.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
    uid: '',
    firstName: '',
    secondName: '',
    email: '',
  );
  final AuthMethods _authMethods = AuthMethods();
  
  UserModel get getUser => _user;
  
  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}