import 'package:flutter/material.dart';
import 'package:login_api_nodejs/bander_sliderimage/slider_image.dart';
import 'package:login_api_nodejs/home.dart';
import 'package:login_api_nodejs/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/sl':(context) => Imageslider(),
      },
    );
  }
}
