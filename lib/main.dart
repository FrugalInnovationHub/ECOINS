import 'package:flutter/material.dart';
import 'game.dart';
import 'screens/main_menu.dart';

void main() {
  // final game = EcoinsGame();
  // runApp(
  //   GameWidget(
  //     game: game,
  //   ),
  // );
  
  runApp(app());
  
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ECOINS",
      home: main_menu(),
    );
  }
}

