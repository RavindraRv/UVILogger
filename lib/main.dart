import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';
import 'package:login/Splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash', // Set the initial route to the SplashScreen
    routes: {
      '/splash': (context) => SplashScreen(), // Define route for SplashScreen
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
    },
  ));
}
