import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class YellowBasureros extends SpriteComponent with HasGameRef{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('yellow_basureros.png');
    position = Vector2(810, 350);
    size = Vector2(50, 100);

    var y_h_box = Basureros_HBox(
        BHBox_Type.Yellow,
        size: Vector2(45,100),
        position: Vector2(6, 0)
    );
    y_h_box.debugColor = Color(0xFFFFF200);
    add(y_h_box);
  }
}
