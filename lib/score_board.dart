import 'package:ecoins/score_disp.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Score_Board extends PositionComponent with HasGameRef{

  SpriteComponent Gota_Agua = SpriteComponent();
  SpriteComponent Sol = SpriteComponent();

  @override
  Future<void> onLoad() async{
    super.onLoad();
    var gameSize = gameRef.size;
    var ratio = gameSize[0]/gameSize[1];

    Gota_Agua
      ..sprite = await gameRef.loadSprite('Gota_agua.png')
      ..size = Vector2(ratio*70, ratio*80)
      ..position = Vector2(ratio*120, ratio*300);


    Sol
      ..sprite = await gameRef.loadSprite('Sol.png')
      ..size = Vector2(ratio*80, ratio*80)
      ..position = Vector2(ratio*20, ratio*300);




    final paint = Paint()
    ..color = Colors.black.withOpacity(0.7)
    ..style = PaintingStyle.fill;
    final rectangle = RectangleComponent(
    size: Vector2(150.0, 200.0),
    position: Vector2(50, 400),

    paint: paint,
    );
    add(Gota_Agua);
    add(Sol);
    // add(rectangle);
  }
}