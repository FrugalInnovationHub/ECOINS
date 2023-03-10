import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class BlueBasureros extends SpriteComponent with HasGameRef{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('blue_basureros.png');
    position = Vector2(755, 350);
    size = Vector2(50, 100);


    var b_h_box = Basureros_HBox(
        BHBox_Type.Blue,
        size: Vector2(45,100),
        position: Vector2(5, 0)
    );
    b_h_box.debugColor = Color(0xFF0033FF);
    add(b_h_box);
  }
}
