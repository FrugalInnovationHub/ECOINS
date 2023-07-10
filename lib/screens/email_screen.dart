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
  ImageSprite box = ImageSprite();
  late OpacityEffect h_opacity_effect;
  late OpacityEffect h_opacity_effect_new;
  late BuildContext context;

  Email_Screen({ required this.context});
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

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
          emailScreen1.removeFromParent();
          add(box);
          box.add(h_opacity_effect_new);
          overlays.add("Email");
          FlameAudio.audioCache.clear("Ending.mp3");
          Future.delayed(Duration(seconds: 1), () {
            Future.delayed(Duration(seconds: 1), () {
              box.removeFromParent();
              add(emailScreen1);
              emailScreen2.removeFromParent();
            });
            gameRef.pauseEngine();
          });
        });
      });
    }
    catch (e){
      Future.delayed(Duration(seconds: 30), () {
        textSprite2.removeFromParent();
        emailScreen1.removeFromParent();
        add(box);
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
      });
      print(e);
    }
  }
}