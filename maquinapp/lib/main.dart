import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_page_signin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Se asegura de que todas las dependencias estén inicializadas
  Firebase.initializeApp().then((value) => {runApp(const MyApp())});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
      title: 'Maquinapp',
      debugShowCheckedModeBanner: false,
      initialRoute: 'Home',
      routes: {'Home': (BuildContext context) => const HomePageSignIn()},
    );
  }
}
