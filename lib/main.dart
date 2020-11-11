import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/root_widget.dart';
import 'package:json_table/json_table.dart';
import 'package:spreadsheet/Detail%20Screen.dart';
import 'package:spreadsheet/file.dart';
import 'package:spreadsheet/test.dart';

import 'Contact.dart';
import 'HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);

  runApp(new GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomeScreen(),
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
  ));
}
