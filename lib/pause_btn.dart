import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';
import 'screens/pause_menu.dart';

class Pause_Btn extends RectangleComponent with HasGameRef, Tappable{
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
    // setColor(Colors.white);

    TextComponent _txt = TextComponent(
        text: '||',
        textRenderer: _paint,
        // size: Vector2(50, 60)
        position: Vector2(10, 0)
    );

    add(_txt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print("Tapped");
    // Marks 'PauseMenu' to be rendered.
    gameRef.overlays.add(pause_menu.pauseOverlayIdentifier);
    gameRef.pauseEngine();
    return true;
  }
}
