import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class Basureros extends PositionComponent with HasGameRef{

  SpriteComponent Blue = SpriteComponent();
  SpriteComponent Yellow = SpriteComponent();
  SpriteComponent Grey = SpriteComponent();
  late double ratio = 1;


  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = double.parse((gameSize[0]/gameSize[1]).toStringAsFixed(1));

    Blue
      ..sprite = await gameRef.loadSprite('blue_basureros.png')
      ..size = Vector2(gameSize[0]*0.104, gameSize[1]*0.33)
      ..position = Vector2(gameSize[0]*0.467, gameSize[1]*0.655);

    add(Blue);

    Yellow
      ..sprite = await gameRef.loadSprite('yellow_basureros.png')
      ..size = Vector2(gameSize[0]*0.104, gameSize[1]*0.33)
      ..position = Vector2(gameSize[0]*0.605, gameSize[1]*0.655);

    add(Yellow);

    Grey
      ..sprite = await gameRef.loadSprite('grey_basureros.png')
      ..size = Vector2(gameSize[0]*0.104, gameSize[1]*0.33)
      ..position = Vector2(gameSize[0]*0.74, gameSize[1]*0.655);

    add(Grey);

    var b_h_box = Basureros_HBox(
        BHBox_Type.Blue,
        size: Vector2(gameSize[0]*0.104, gameSize[1]*0.33),
        position: Vector2(gameSize[0]*0.467, gameSize[1]*0.68)
    );
    b_h_box.debugColor = Color(0xFF0033FF);
    add(b_h_box);

    var y_h_box = Basureros_HBox(
        BHBox_Type.Yellow,
        size: Vector2(gameSize[0]*0.104, gameSize[1]*0.33),
        position: Vector2(gameSize[0]*0.605, gameSize[1]*0.68)
    );
    y_h_box.debugColor = Color(0xFFFFF200);
    add(y_h_box);

    var grey_h_box = Basureros_HBox(
        BHBox_Type.Grey,
        size: Vector2(gameSize[0]*0.104, gameSize[1]*0.33),
        position: Vector2(gameSize[0]*0.74, gameSize[1]*0.68)
    );
    grey_h_box.debugColor = Color(0xFFFFFFFF);
    add(grey_h_box);
  }
}
