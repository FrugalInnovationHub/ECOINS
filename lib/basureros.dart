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
  SpriteComponent Green = SpriteComponent();
  SpriteComponent Yellow = SpriteComponent();
  SpriteComponent Grey = SpriteComponent();
  SpriteComponent BlueLevel1 = SpriteComponent();
  SpriteComponent BlueLevel2 = SpriteComponent();
  SpriteComponent BlueLevel3 = SpriteComponent();
  SpriteComponent BlueLevel4 = SpriteComponent();
  late double ratio = 1;


  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = gameSize[0]/gameSize[1];

    // Green
    //   ..sprite = await gameRef.loadSprite('green_basureros.png')
    //   ..size = Vector2(gameSize[1]/4, gameSize[0]/4)
    //   ..position = Vector2(gameSize[0]/4, gameSize[1]/2);
    //
    // add(Green);

    Blue
      ..sprite = await gameRef.loadSprite('blue_basureros.png')
      ..size = Vector2(ratio*80, ratio*150)
      ..position = Vector2(ratio*290, ratio*310);

    add(Blue);

    Yellow
      ..sprite = await gameRef.loadSprite('yellow_basureros.png')
      ..size = Vector2(ratio*80, ratio*150)
      ..position = Vector2(ratio*400, ratio*310);

    add(Yellow);

    Grey
      ..sprite = await gameRef.loadSprite('grey_basureros.png')
      ..size = Vector2(ratio*80, ratio*150)
      ..position = Vector2(ratio*510, ratio*310);

    add(Grey);



    // sprite = await gameRef.loadSprite('basureros.png');
    // position = Vector2(700, 400);
    // size = Vector2(200, 100);

    // var g_h_box = Basureros_HBox(
    //   BHBox_Type.Green,
    //   size: Vector2(gameSize[1]/4, gameSize[0]/4),
    //   position: Vector2(gameSize[0]/4, (gameSize[1]/2))
    // );
    // g_h_box.debugColor = Color(0xFF00FF00);
    // add(g_h_box);

    var b_h_box = Basureros_HBox(
        BHBox_Type.Blue,
        size: Vector2(ratio*80, ratio*150),
        position: Vector2(ratio*290, ratio*310)
    );
    b_h_box.debugColor = Color(0xFF0033FF);
    add(b_h_box);

    var y_h_box = Basureros_HBox(
        BHBox_Type.Yellow,
        size: Vector2(ratio*80, ratio*150),
        position: Vector2(ratio*400, ratio*310)
    );
    y_h_box.debugColor = Color(0xFFFFF200);
    add(y_h_box);

    var grey_h_box = Basureros_HBox(
        BHBox_Type.Grey,
        size: Vector2(ratio*80, ratio*150),
        position: Vector2(ratio*510, ratio*310)
    );
    grey_h_box.debugColor = Color(0xFFFFFFFF);
    add(grey_h_box);


  }
}
