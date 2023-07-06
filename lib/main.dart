import 'package:ecoins/components/DataTextField.dart';
import 'package:ecoins/screens/email_screen.dart';
import 'package:ecoins/screens/home_screen.dart';
import 'package:ecoins/screens/pause_menu.dart';
// import 'package:ecoins/screens/videoPlayerScreen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/EmailTextField.dart';
import 'game.dart';
import 'screens/main_menu.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
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
        '/': (context) => GameWidget(
            game: HomeScreen(context: context),
          overlayBuilderMap: {
              "EnterData": (BuildContext context, HomeScreen game) {
                return DataTextField(game: game);
              }
          },
        ),
        // "/video": (context) =>  VideoPlayerScreen(),
        "/email": (context) => GameWidget(game: Email_Screen(context: context), overlayBuilderMap: {
          'Email':
              (BuildContext context, Email_Screen game) {
            return EmailTextField(game: game);
          }
        }),
        // "/game": (context) => GameWidget(
        //     game: EcoinsGame(context: context),
        //     overlayBuilderMap: {
        //       'PauseMenu':
        //           (BuildContext context, EcoinsGame game) {
        //         return pause_menu(game: game);
        //       }
        //     }
        // )
      },
    );
  }
}

