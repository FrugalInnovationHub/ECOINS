import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1 , vertical: MediaQuery.of(context).size.height*0.1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Paused',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.08,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.08,
                ),
                ElevatedButton(
                  onPressed: () {
                    this.game.overlays.remove(pauseOverlayIdentifier);
                    this.game.resumeEngine();
                    FlameAudio.bgm.resume();
                  },
                  child: Text(
                    'Resume',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.05,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}