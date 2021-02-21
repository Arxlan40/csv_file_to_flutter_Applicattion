
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/root_widget.dart';

import 'package:spreadsheet/Splashscreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);

  runApp(new GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
  ));
}
