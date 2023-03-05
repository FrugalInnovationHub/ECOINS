import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class Basureros extends SpriteComponent with HasGameRef{

  SpriteComponent Blue = SpriteComponent();
  SpriteComponent Green = SpriteComponent();
  SpriteComponent Yellow = SpriteComponent();
  SpriteComponent Grey = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    Blue
      ..sprite = await gameRef.loadSprite('blue_basureros.png')
      ..size = Vector2(45, 100)
      ..position = Vector2(700, 350);

    // add(Blue);

    Green
      ..sprite = await gameRef.loadSprite('green_basureros.png')
      ..size = Vector2(45, 100)
      ..position = Vector2(750, 350);

    // add(Green);

    Yellow
      ..sprite = await gameRef.loadSprite('yellow_basureros.png')
      ..size = Vector2(45, 100)
      ..position = Vector2(800, 350);

    // add(Yellow);

    Grey
      ..sprite = await gameRef.loadSprite('grey_basureros.png')
      ..size = Vector2(45, 100)
      ..position = Vector2(850, 350);

    // add(Grey);



    sprite = await gameRef.loadSprite('basureros.png');
    position = Vector2(700, 400);
    size = Vector2(200, 100);

    var g_h_box = Basureros_HBox(
      BHBox_Type.Green,
      size: Vector2(45,100),
      position: Vector2(2, 0)
    );
    g_h_box.debugColor = Color(0xFF00FF00);
    add(g_h_box);

    var b_h_box = Basureros_HBox(
        BHBox_Type.Blue,
        size: Vector2(45,100),
        position: Vector2(52, 0)
    );
    b_h_box.debugColor = Color(0xFF0033FF);
    add(b_h_box);

    var y_h_box = Basureros_HBox(
        BHBox_Type.Yellow,
        size: Vector2(45,100),
        position: Vector2(102, 0)
    );
    y_h_box.debugColor = Color(0xFFFFF200);
    add(y_h_box);

    var grey_h_box = Basureros_HBox(
        BHBox_Type.Grey,
        size: Vector2(45,100),
        position: Vector2(152, 0)
    );
    grey_h_box.debugColor = Color(0xFFFFFFFF);
    add(grey_h_box);


  }
}
