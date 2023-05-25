import 'package:ecoins/screens/email_screen.dart';
import 'package:ecoins/screens/home_screen.dart';
import 'package:ecoins/screens/pause_menu.dart';
import 'package:ecoins/screens/videoPlayerScreen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'TextField.dart';
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
        "/video": (context) =>  VideoPlayerScreen(),
        "/email": (context) => GameWidget(game: Email_Screen(context: context), overlayBuilderMap: {
          'textField':
              (BuildContext context, Email_Screen game) {
            return TextFieldExampleApp();
          }
        }),
        "/game": (context) => GameWidget(
            game: EcoinsGame(),
            overlayBuilderMap: {
              'PauseMenu':
                  (BuildContext context, EcoinsGame game) {
                return pause_menu(game: game);
              }
            }
        )
      },
    );
  }
}

