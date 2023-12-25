import 'package:flutter/material.dart';

class AppVersionModel {
  String appName;

  String packageName;
  String version;

  String buildNumber;

  AppVersionModel({
    required this.packageName,
    required this.version,
    required this.appName,
    required this.buildNumber,
  });
}
