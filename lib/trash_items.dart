import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';
import 'game.dart';
import 'score_disp.dart';

enum Trash_Type implements Comparable<Trash_Type> {
  Botella_Plastico(src: 'botella_plastico.png'),
  Botella_Vidrio(src: 'botella_vidrio.png'),
  Caja_Jugo(src: 'caja_jugo.png'),
  Caja_Leche(src: 'caja_leche.png'),
  Caja_Leche_Purp(src: 'caja_leche_purp.png');

  const Trash_Type({
    required this.src
  });

  final src;

  @override
  int compareTo(Trash_Type other) {
    if (src == other.src) {
      return 0;
    } else {
      return -1;
    }
  }
}

class Trash_Item extends SpriteComponent with HasGameRef, Tappable, CollisionCallbacks, ParentIsA<EcoinsGame> {
  late MoveEffect h_move_effect;
  bool is_moving = true;
  bool is_colliding = false;
  bool scored = false;
  Trash_Type type;
  int delay;

  Trash_Item(Trash_Type type, int delay) : this.type = type, this.delay = delay;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-20, 50);
    size = Vector2(18, 50);

    add(RectangleHitbox());

    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, 50),
      EffectController(
        startDelay: (1*delay) as double,
        duration: 10,
        infinite: true,
        alternate: true
      ),
    );

    update_move();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true;
    if(is_colliding) {
      position = Vector2(position.x, position.y + 100);
    }
    return false;
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
      if (!scored) {
        final allPositionComponents = parent.children.query<
            PositionComponent>();
        Score_Disp ?score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Score_Disp) {
            score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Green:
            if (this.type == Trash_Type.Botella_Vidrio) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
              }
            } else {
              position = Vector2(position.x, position.y - 100);
            }
            break;
          case BHBox_Type.Blue:
            if (this.type == Trash_Type.Botella_Plastico) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
              }
            } else {
              position = Vector2(position.x, position.y - 100);
            }
            // removeFromParent();
            break;
          case BHBox_Type.Yellow:
          // if(this.type != Trash_Type.Botella_Plastico) {
            position = Vector2(position.x, position.y - 100);
            // }
            break;
          case BHBox_Type.Grey:
            if (
            this.type == Trash_Type.Caja_Jugo ||
                this.type == Trash_Type.Caja_Leche ||
                this.type == Trash_Type.Caja_Leche_Purp
            ) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
              }
            } else {
              position = Vector2(position.x, position.y - 100);
            }
            break;
          default:
            {}
        }
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
