import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_page_signin.dart';
import 'Pages/home/home_page.dart';


void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatefulWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maquinapp',
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home',
      routes: {
        'Home': (BuildContext context) => const HomePageSignIn()
      },
    );
  }
}