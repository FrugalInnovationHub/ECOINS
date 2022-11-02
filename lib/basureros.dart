import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';

import 'basureros_hbox.dart';

class Basureros extends SpriteComponent with HasGameRef{
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('basureros.png');
    position = Vector2(700, 400);
    size = Vector2(200, 100);

    var g_h_box = Basureros_HBox(
      Type.Green,
      size: Vector2(45,100),
      position: Vector2(2, 0)
    );
    g_h_box.debugColor = Color(0xFF00FF00);
    add(g_h_box);

    var b_h_box = Basureros_HBox(
        Type.Blue,
        size: Vector2(45,100),
        position: Vector2(52, 0)
    );
    b_h_box.debugColor = Color(0xFF0033FF);
    add(b_h_box);

    var y_h_box = Basureros_HBox(
        Type.Yellow,
        size: Vector2(45,100),
        position: Vector2(102, 0)
    );
    y_h_box.debugColor = Color(0xFFFFF200);
    add(y_h_box);

    var grey_h_box = Basureros_HBox(
        Type.Grey,
        size: Vector2(45,100),
        position: Vector2(152, 0)
    );
    grey_h_box.debugColor = Color(0xFFFFFFFF);
    add(grey_h_box);
  }
}
