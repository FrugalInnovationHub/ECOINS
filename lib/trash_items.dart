import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';

class Botella_Plastico extends SpriteComponent with HasGameRef, Tappable, CollisionCallbacks {
  late MoveEffect h_move_effect;
  bool is_moving = true;
  bool is_colliding = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('botella_plastico.png');
    position = Vector2(-20, 50);
    size = Vector2(18, 50);

    add(RectangleHitbox());

    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, 50),
      EffectController(
        duration: 10,
        infinite: true,
        alternate: true
        // curve: Curves.ease,
      ),
    );

    update_move();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if(is_colliding) {
      position = Vector2(position.x, position.y + 100);
      return true;
    } else {
      return false;
    }
  }

  update_move() {
    if(is_moving == true) {
      add(h_move_effect);
    } else {
      h_move_effect.removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Banda_T_Hole) {
      is_colliding = true;
    } else if (other is Basureros_HBox) {
      // print("Hit ${other.type}");
      if(other.type == Type.Green) {
        position = Vector2(position.x, position.y - 100);
      } else if(other.type == Type.Blue) {
        removeFromParent();
      } else if(other.type == Type.Yellow) {
        position = Vector2(position.x, position.y - 100);
      } else if(other.type == Type.Grey) {
        position = Vector2(position.x, position.y - 100);
      } else {

      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Banda_T_Hole) {
      is_colliding = false;
    }
  }

}
