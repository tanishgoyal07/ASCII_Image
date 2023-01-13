import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ascii_image/constants/utils.dart';
import 'package:ascii_image/providers/user_provider.dart';
import 'package:ascii_image/screens/home_screen.dart';
import 'package:ascii_image/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Ascii Image',
        theme: ThemeData(
          primaryColor: GlobalVariables.mainColor,
          primarySwatch: Colors.green,
          inputDecorationTheme: const InputDecorationTheme(
            prefixIconColor: GlobalVariables.mainColor,
           
          ),
        ).copyWith(
          scaffoldBackgroundColor: GlobalVariables.secondaryColor,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: GlobalVariables.mainColor),
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 8),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: GlobalVariables.mainColor,
                    ),
                  );
                }
                return const LoginScreen();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalVariables.secondaryColor,
      width: 250.0,
      child: Center(
        child: DefaultTextStyle(
          style: GoogleFonts.specialElite(
            color: GlobalVariables.mainColor,
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'ASCII-STUDIO',
                speed: const Duration(milliseconds: 600),
                cursor: '|',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
