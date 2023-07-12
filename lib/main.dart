import 'package:ecoins/components/DataTextField.dart';
import 'package:ecoins/screens/email_screen.dart';
import 'package:ecoins/screens/home_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/EmailTextField.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(app());
  
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ECOINS",
      initialRoute: "/email",
      routes: {
        '/': (context) => GameWidget(
            game: HomeScreen(context: context),
          overlayBuilderMap: {
              "EnterData": (BuildContext context, HomeScreen game) {
                return DataTextField(game: game);
              }
          },
        ),
        "/email": (context) => GameWidget(game: Email_Screen(context: context), overlayBuilderMap: {
          'Email':
              (BuildContext context, Email_Screen game) {
            return EmailTextField(game: game);
          }
        }),
      },
    );
  }
}

