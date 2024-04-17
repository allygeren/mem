import 'package:flutter/material.dart';
import 'package:mem/screens/game_screen.dart';
import 'package:mem/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          routes: {
            HomeScreen.id: (context) => HomeScreen(),
            //GameScreen.id: (context) => GameScreen(),
          },
          home: Scaffold(
            body: HomeScreen(),
          )
      );
  }
}
