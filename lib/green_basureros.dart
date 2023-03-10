import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class GreenBasureros extends SpriteComponent with HasGameRef{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('green_basureros.png');
    position = Vector2(700, 350);
    size = Vector2(50, 100);

    var g_h_box = Basureros_HBox(
        BHBox_Type.Green,
        size: Vector2(45,100),
        position: Vector2(2, 0)
    );
    g_h_box.debugColor = Color(0xFF00FF00);
    add(g_h_box);
  }
}
