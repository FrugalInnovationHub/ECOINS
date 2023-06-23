
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';

class TutorialAnimation extends PositionComponent with HasGameRef{
  late final text_url;
  late final audio_url;
  late final align;
  late final is_girl_image;
  TutorialAnimation({super.position, super.size, required this.text_url, required this.audio_url, required this.align, required this.is_girl_image});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var audio;
    priority = 10;
    SpriteComponent textSprite;

    var sprite = await gameRef.loadSprite(this.text_url);
    textSprite = SpriteComponent(sprite: sprite, position: Vector2.all(0), size: size);

    if(this.is_girl_image) {
      SpriteComponent girlSprite = SpriteComponent(
          sprite: await gameRef.loadSprite("NINA_POP_UP.png"),
          size: Vector2(gameRef.size[0] * 0.20, gameRef.size[1] * 0.35));

      if(align == "left") {
        girlSprite.position = Vector2(-gameRef.size[0]*0.16, gameRef.size[1]*0.05);
      }
      else {
        girlSprite.position = Vector2(size[0] - gameRef.size[0]*0.05 , gameRef.size[1]*0.05);
      }

      add(girlSprite);
    }

    add(textSprite);
    FlameAudio.bgm.pause();
    audio = await FlameAudio.play(this.audio_url);

    audio.onPlayerStateChanged.listen((event) {
      textSprite.removeFromParent();

      this.removeFromParent();
      gameRef.resumeEngine();
      FlameAudio.bgm.resume();
    });

    Future.delayed(Duration(seconds: 1), () async { gameRef.pauseEngine(); } );

  }
}