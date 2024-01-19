import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/auth/auth_model.dart';
import '../encrypt/encrypt.dart';

class Token {
  static AuthModel? appAuthModel;

  static Future<AuthModel> setToken({required AuthModel resultModel}) async {
    appAuthModel = resultModel;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", resultModel.accessToken!);
    return resultModel;
  }

  static Future<(String? uid, String? pwd)> checkUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString("username");
    String? password = prefs.getString("password");

    username = username == null ? null : Encrypt.decryptedText(text: username);
    password = password == null ? null : Encrypt.decryptedText(text: password);

    return (username, password);
  }

  static Future<bool> savedUser(
      {required String username, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = Encrypt.encryptText(text: username);
    password = Encrypt.encryptText(text: password);

    await prefs.setString("username", username);
    await prefs.setString("password", password);
    return true;
  }

  static Future<bool> removeUserSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = await prefs.remove("username");
    var password = await prefs.remove("password");
    var token = await prefs.remove("token");
    if (username == true && password == true) return true;
    return false;
  }
}
