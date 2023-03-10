import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';


import 'basureros_hbox.dart';

class GreyBasureros extends SpriteComponent with HasGameRef{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('grey_basureros.png');
    position = Vector2(865 , 350);
    size = Vector2(50, 100);

    var grey_h_box = Basureros_HBox(
        BHBox_Type.Grey,
        size: Vector2(45,100),
        position: Vector2(10, 0)
    );
    grey_h_box.debugColor = Color(0xFFFFFFFF);
    add(grey_h_box);
  }
}
