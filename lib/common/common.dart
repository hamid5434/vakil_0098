import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:vakil_0098/model/version/app_version_model.dart';

import 'public_variable/public_variable.dart';

class Common {
  static String StrConvertNumE2P(String strInput) {
    //String[] str = {'٠','١','٢','٣','٤','٥','٦','٧','٨','٩'};
    //char[] strFa = new char[]{'٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'};
    List<int> asciInt = [
      1776,
      1777,
      1778,
      1779,
      1780,
      1781,
      1782,
      1783,
      1784,
      1785
    ];
    var t1 = '/'.codeUnits;
    var t2 = ','.codeUnits;
    var t3 = '.'.codeUnits;

    List<String> strEn = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String strFinal = "";
    bool temp = true;
    for (int i = 0; i < strInput.length; i++) {
      temp = true;
      for (int j = 0; j < asciInt.length; j++) {
        var c = strInput.codeUnits[i];
        var c1 = String.fromCharCode(asciInt[j]).codeUnits.first;
        if (c == c1) {
          strFinal += strEn[j];
          temp = false;
          break;
        } else if (c == String.fromCharCode(1643) ||
            c == String.fromCharCode(t1[0]) ||
            c == String.fromCharCode(t2[0]) ||
            c == String.fromCharCode(t3[0])) {
          strFinal += ".";
          temp = false;
          break;
        }
      }
      if (temp) {
        strFinal += strInput[i];
      }
    }
    return strFinal;
  }

  static Future<AppVersionModel> getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    AppVersionModel appVersion = AppVersionModel(
        appName: appName,
        packageName: packageName,
        version: version,
        buildNumber: buildNumber);
    return appVersion;
  }

  static String themeType = 'light';

  static Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeType = await prefs.getString("themeType") ?? 'light';
    PublicVariable.themeChangeNotifier.value = themeType;
    return themeType;
  }

  static Future<bool> setTheme({required String themeType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeType", themeType);
    return true;
  }

  static void showToast(
      {required String msg,
        required BuildContext context,
        Color textColor = Colors.white,
        Color? backColor = Colors.black,
        double fontSize = 13,
        String pos = 'bottom',
        String title = 'OK',
        String type = 'error'}) {
    ToastificationType toastificationType = ToastificationType.error;
    if (type == 'warning') {
      toastificationType = ToastificationType.warning;
    } else if (type == 'success') {
      toastificationType = ToastificationType.success;
    }else if (type == 'info') {
      toastificationType = ToastificationType.info;
    }

    toastification.show(
      context: context,
      type: toastificationType,
      style: ToastificationStyle.fillColored,
      title: title,
      description: msg,
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  //
  // static void showToast(
  //     {required String msg,
  //     required BuildContext context,
  //     Color textColor = Colors.white,
  //     Color? backColor = Colors.black,
  //     double fontSize = 13,
  //     String pos = 'bottom'}) {
  //
  //   Toastification().show(
  //     context: context,
  //     title: msg,
  //     autoCloseDuration: const Duration(seconds: 5),
  //   );
  // }

}
