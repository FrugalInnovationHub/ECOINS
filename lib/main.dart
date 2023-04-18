import 'package:ecoins/screens/home_screen.dart';
import 'package:ecoins/screens/videoPlayerScreen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'screens/main_menu.dart';

void main() {
  runApp(app());
  
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ECOINS",
      initialRoute: "/",
      routes: {
        '/': (context) => GameWidget(game: HomeScreen(context: context)),
        "/game": (context) =>  VideoPlayerScreen(),
      },
    );
  }
}

