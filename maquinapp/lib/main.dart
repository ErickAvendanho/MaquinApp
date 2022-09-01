import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_page_signin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maquinapp/Pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Se asegura de que todas las dependencias estén inicializadas
  Firebase.initializeApp().then((value) => {runApp(const MyApp())});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
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
      routes: {
        'Home': (BuildContext context) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                            Image.asset('assets/images/wellnesstar-logo.jpeg'),
                      ),
                      const CircularProgressIndicator(),
                    ],
                  );
                } else if (stream.hasData) {
                  return const HomePage();
                } else {
                  return const HomePageSignIn();
                }
              },
            ),
      },
    );
  }
}
