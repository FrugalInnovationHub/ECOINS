import 'package:ecoins/game.dart';
import 'package:ecoins/screens/home_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/ImageSprite.dart';
import 'package:flame_audio/flame_audio.dart';


class Email_Screen extends FlameGame with HasTappables, HasGameRef{
  ImageSprite emailScreen1 = ImageSprite();
  ImageSprite emailScreen2 = ImageSprite();
  ImageSprite leaf1 = ImageSprite();
  ImageSprite leaf2 = ImageSprite();
  ImageSprite tus_puntos = ImageSprite();
  ImageSprite tus_ecoins = ImageSprite();
  ImageSprite icono_ecoins = ImageSprite();
  ImageSprite box = ImageSprite();
  late OpacityEffect h_opacity_effect;
  late OpacityEffect h_opacity_effect_new;
  late BuildContext context;
  int ecoins = EcoinsGame.finalEcoins;

  Email_Screen({ required this.context});
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  void addEmailBox() {
    add(box);
    leaf1.removeFromParent();
    leaf2.removeFromParent();
    tus_ecoins.removeFromParent();
    tus_puntos.removeFromParent();
    icono_ecoins.removeFromParent();
    box.add(h_opacity_effect_new);
    overlays.add("Email");
    Future.delayed(Duration(seconds: 1), () {
      Future.delayed(Duration(seconds: 1), () {
        box.removeFromParent();
        add(emailScreen1);
        emailScreen2.removeFromParent();
      });
      gameRef.pauseEngine();
    });
  }

  void addPointsLeaf() async {
    emailScreen1.removeFromParent();
    await add(leaf1);
    leaf1.addText(ecoins);
    await add(leaf2);
    leaf2.addText(ecoins);
    add(tus_puntos);
    add(tus_ecoins);
    add(icono_ecoins);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var y = (size[0] / 16)*9;
    camera.viewport = FixedResolutionViewport(Vector2(size[0], y));
    if(FlameAudio.bgm.isPlaying) {
      FlameAudio.bgm.stop();
      FlameAudio.bgm.dispose();
    }
    emailScreen1 = ImageSprite(asset: 'EndScreen_1.jpeg',
        position: Vector2(0,0),
        size: Vector2(size[0], size[1]));
    emailScreen2 = ImageSprite(asset: 'EndScreen_2.jpeg',
        position: Vector2(0,0),
        size: Vector2(size[0], size[1]));
    box = ImageSprite(asset: 'box.png',
        position: Vector2(size[0] * 0.49 ,size[1] * 0.30),
        size: Vector2(size[0] * 0.49, size[1] * 0.4));

    leaf1 = ImageSprite(asset: "SCORE.png",
        position: Vector2(size[0] * 0.52 ,size[1] * 0.25),
        size: Vector2(size[0] * 0.20, size[1] * 0.4));
    leaf2 = ImageSprite(asset: "SCORE.png",
        position: Vector2(size[0] * 0.71 ,size[1] * 0.28),
        size: Vector2(size[0] * 0.21, size[1] * 0.42));
    tus_puntos = ImageSprite(asset: 'Tus_Puntos.png',
        position: Vector2(size[0] * 0.55 ,size[1] * 0.34),
        size: Vector2(size[0] * 0.15, size[1] * 0.07)
    );
    tus_ecoins = ImageSprite(asset: 'Tus_Ecoins.png',
        position: Vector2(size[0] * 0.74 ,size[1] * 0.37),
        size: Vector2(size[0] * 0.15, size[1] * 0.07)
    );
    icono_ecoins = ImageSprite(asset: 'ICONO_ECOINS.png',
        position: Vector2(size[0] * 0.73 ,size[1] * 0.48),
        size: Vector2(size[0] * 0.04, size[1] * 0.08)
    );
    box.opacity = 0;
    h_opacity_effect = OpacityEffect.to(0, EffectController(duration: 1, startDelay: 3));
    h_opacity_effect_new = OpacityEffect.to(1, EffectController(duration: 1, startDelay: 0));
    await add(emailScreen2);
    await add(emailScreen1);
    // emailScreen2.add(h_opacity_effect_new);
    ImageSprite textSprite1 = ImageSprite(asset: "Ending_1.png",position: Vector2(size[0]*0.5, size[1]*0.01), size: Vector2(size[0]*0.45, size[1]*0.2));
    ImageSprite textSprite2 = ImageSprite(asset: "Ending_2.png",position: Vector2(size[0]*0.5, size[1]*0.01), size: Vector2(size[0]*0.45, size[1]*0.2));

    await add(textSprite1);
    Future.delayed(Duration(seconds: 16), () async { textSprite1.removeFromParent(); await add(textSprite2);});
    try {
      var audio = await FlameAudio.playLongAudio("Ending.mp3");
      audio.onPlayerStateChanged.listen((event) {
        textSprite2.removeFromParent();

        Future.delayed(Duration(milliseconds: 30), () {
          addPointsLeaf();
          Future.delayed(Duration(seconds: 4), () { addEmailBox(); });
          FlameAudio.audioCache.clear("Ending.mp3");
        });
      });
    }
    catch (e){
      Future.delayed(Duration(seconds: 30), () {
        textSprite2.removeFromParent();
        addPointsLeaf();
        Future.delayed(Duration(seconds: 4), () { addEmailBox(); });
      });
      print(e);
    }
  }
}

class email_screen_playagain extends StatelessWidget {
  const email_screen_playagain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
                visible: true,
                child: FloatingActionButton(
                  heroTag: "Skip",
                  tooltip: "Skip",
                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    // Navigator.pushReplacementNamed(this.context, '/game');
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => GameWidget(
                        game: HomeScreen(context: context),
                      ),
                    ));
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(Icons.skip_next),
                )),

            SizedBox(
              height: 10,
            )
          ],
        )
    );
  }
}
