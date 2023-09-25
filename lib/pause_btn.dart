import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'screens/pause_menu.dart';

class Pause_Btn extends PositionComponent with HasGameRef, Tappable {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    final _style = TextStyle(
        color: BasicPalette.lightOrange.color,
        fontSize: gameRef.size[0]*0.035,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(gameRef.size[1]*0.015, gameRef.size[0]*0.52);
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
      // position: Vector2(gameRef.size[1]*0.015, gameRef.size[0]*0.52),
      paint: _rect_paint
    );

    add(_rect);
    add(_txt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true;
    // Marks 'PauseMenu' to be rendered.
    gameRef.overlays.add(pause_menu.pauseOverlayIdentifier);
    gameRef.pauseEngine();
    FlameAudio.bgm.pause();
    return false;
  }
}
