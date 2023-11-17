import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'screens/pause_menu.dart';

class Mute_Btn extends PositionComponent with HasGameRef, Tappable {
  bool isPlaying = true;
  SpriteComponent mute_btn = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final _style = TextStyle(
        color: BasicPalette.lightOrange.color,
        fontSize: gameRef.size[0]*0.035,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(gameRef.size[1]*0.15, gameRef.size[0]*0.52);
    size = Vector2(gameRef.size[1]*0.06, gameRef.size[0]*0.11);

    TextComponent _txt = TextComponent(
        text: '||',
        textRenderer: _paint,
        position: Vector2(gameRef.size[0]*0.015, 0)
    );

    Paint _rect_paint = Paint();
    _rect_paint.color = Colors.white;
    RectangleComponent _rect = RectangleComponent(
        size: Vector2(gameRef.size[1]*0.08, gameRef.size[0]),
        // position: Vector2(gameRef.size[1]*0.09, gameRef.size[0]*0.52),
        paint: _rect_paint
    );
    mute_btn
      ..sprite = await gameRef.loadSprite('mute-button.png')
      ..size = Vector2(gameRef.size[1]*0.07, gameRef.size[0]*0.04);





    add(_rect);
    // add(_txt);
    add(mute_btn);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true;
    // Marks 'PauseMenu' to be rendered.
    if(isPlaying == true) {
      FlameAudio.bgm.pause();
      isPlaying = false;
    }
    else {
      FlameAudio.bgm.resume();
      isPlaying = true;
    }

    return false;
  }
}