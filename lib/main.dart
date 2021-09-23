import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/auth/auth.dart';
import 'package:poshop/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Color(0xff44454f).withOpacity(0.4),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Auth(),
    );
  }
}

