import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flame/game.dart';

import 'package:ecoins/game.dart';

class pause_menu extends StatelessWidget{
  static final pauseOverlayIdentifier = 'PauseMenu';
  final game;
  const pause_menu({Key? key, this.game, EcoinsGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                const Text(
                  'Paused',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    this.game.overlays.remove(pauseOverlayIdentifier);
                    this.game.resumeEngine();
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) => GameWidget(
                    //         game: EcoinsGame(),
                    //         overlayBuilderMap: {
                    //           'PauseMenu':
                    //               (BuildContext context, EcoinsGame game) {
                    //             return pause_menu();
                    //           }
                    //         })));
                  },
                  child: const Text(
                    'Resume',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}