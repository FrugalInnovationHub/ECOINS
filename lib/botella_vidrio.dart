import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';

class Botella_Vidrio extends SpriteComponent
    with HasGameRef, Tappable, CollisionCallbacks {
  late MoveEffect h_move_effect;
  bool is_moving = true;
  //bool is_colliding = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('botella_vidrio.png');
    position = Vector2(-18, 50);
    size = Vector2(18, 50);

    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, 50),
      EffectController(
        startDelay: 10,
        duration: 15,
        infinite: true,
        curve: Curves.linear,
      ),
    );

    update_move();
  }

  update_move() {
    if (is_moving == true) {
      add(h_move_effect);
    } else {
      h_move_effect.removeFromParent();
    }
  }
}
