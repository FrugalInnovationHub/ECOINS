import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player_web/video_player_web.dart';
import 'package:flame/game.dart';
import 'package:ecoins/game.dart';
import 'package:ecoins/screens/pause_menu.dart';

class main_menu extends StatelessWidget {
  const main_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlameAudio.bgm.initialize();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Cocina.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Card(
            color: Colors.black.withOpacity(0.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/ecoins_logo.png',
                      width: 400,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => GameWidget(
                                    game: EcoinsGame(),
                                    overlayBuilderMap: {
                                      'PauseMenu':
                                          (BuildContext context, EcoinsGame game) {
                                        return pause_menu(game: game);
                                      }
                                    })));
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
