import 'package:ecoins/score_disp.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Score_Board extends FlameGame with HasGameRef{

  @override
  Future<void> onLoad() async{
    super.onLoad();
    await Flame.images.loadAll(<String>[
      'Gota_agua.png',
      'Sol.png'
    ]);
    final gota_agua = SpriteComponent.fromImage(
      Flame.images.fromCache('Gota_agua.png'),
      position: Vector2(100, 480),// Set your position here
      size: Vector2(50, 50), // Set your size here (by default it is 0),
    );

    final sol = SpriteComponent.fromImage(
      Flame.images.fromCache('Sol.png'),
      position: Vector2(100, 400), // Set your position here
      size: Vector2(50, 50), // Set your size here (by default it is 0),
    );



    final paint = Paint()
    ..color = Colors.black.withOpacity(0.7)
    ..style = PaintingStyle.fill;
    final rectangle = RectangleComponent(
    size: Vector2(150.0, 200.0),
    position: Vector2(50, 400),

    paint: paint,
    );
    add(rectangle);
    add(gota_agua);
    add(sol);
  }
}