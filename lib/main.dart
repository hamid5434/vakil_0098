import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vakil_0098/common/public_variable/public_variable.dart';
import 'package:vakil_0098/screen/auth/login_screen.dart';
import 'package:vakil_0098/screen/splash/splash_screen.dart';

import 'common/common.dart';
import 'common/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // supportedLocales: L10N.all,
      // navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("fa", "IR") ,
      title: 'قانون تایم',
      theme: theme(themeType: PublicVariable.themeChangeNotifier.value),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

