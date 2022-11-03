import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
// import 'package:flame/gestures.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';
import 'screens/pause_menu.dart';

class Pause_Btn extends PositionComponent with HasGameRef, Tappable {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    final _style = TextStyle(
        color: BasicPalette.lightOrange.color,
        fontSize: 48.0,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(0, 0);
    size = Vector2(50, 60);

    TextComponent _txt = TextComponent(
        text: '||',
        textRenderer: _paint,
        position: Vector2(13, 0)
    );
    Paint _rect_paint = Paint();
    _rect_paint.color = Colors.white;
    RectangleComponent _rect = RectangleComponent(
      size: Vector2(50, 60),
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
    return false;
  }
}
