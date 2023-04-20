import 'package:ecoins/gray_score.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';
import 'blue_score.dart';
import 'game.dart';
import 'green_score.dart';
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

class Trash_Item extends SpriteComponent
    with HasGameRef, Tappable, CollisionCallbacks, ParentIsA<EcoinsGame> {
  late MoveEffect h_move_effect;
  bool is_moving = true;
  bool is_colliding = false;
  bool scored = false;
  bool green_scored = false;
  bool blue_scored = false;
  bool grey_scored = false;
  Trash_Type type;
  double delay;
  double y_loc;
  late OpacityEffect h_opacity_effect;

  Trash_Item(Trash_Type type, double delay, double y_loc) :
        this.type = type, this.delay = delay, this.y_loc = y_loc;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-30, y_loc);
    size = Vector2(30, 70);

    add(RectangleHitbox());
    h_opacity_effect = OpacityEffect.to(0, EffectController(duration: 0.75, startDelay: 3));
    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, y_loc),
      EffectController(
        startDelay: 1.5*delay,
        duration: 20,
        infinite: true,
        alternate: true
      ),
    );

    update_move();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true

    if(is_colliding) {
      if((gameRef.size[1]/8 - 50) == position.y) {
        position = Vector2(position.x, gameRef.size[1]/4 - 50);
      }
      else if((gameRef.size[1]/4 - 50) == position.y) {
        position = Vector2(position.x, gameRef.size[1]/2.5 - 50);
      }
      else{
        position = Vector2(position.x, position.y + 100);
      }
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
    } else if (other is Trash_Item ) {
      // position = Vector2(position.x - 20 , position.y);
    } else if (other is Basureros_HBox) {

      if (!green_scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
        Green_Score_Disp ?green_score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Green_Score_Disp) {
            green_score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Green:
            if (this.type == Trash_Type.Botella_Vidrio) {
              this.is_moving = false;
              update_move();
              if (green_score != null) {
                green_scored = true;
                green_score.green_updateScore(1);
                add(h_opacity_effect);
              }
            } else {
              // position = Vector2(position.x, position.y - 100);
            }
            // green_scored = false;
            break;

          default:
            {}
        }
      }


      if (!blue_scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
        Blue_Score_Disp ?blue_score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Blue_Score_Disp) {
            blue_score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Blue:
            if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Caja_Jugo) {
              this.is_moving = false;
              update_move();
              if (blue_score != null) {
                blue_scored = true;
                blue_score.blue_updateScore(1);
                add(h_opacity_effect);
              }
            } else {
              // position = Vector2(position.x, position.y - 100);
            }
            // blue_scored = false;
            break;

          default:
            {}
        }
      }

      if (!grey_scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
        Gray_Score_Disp ?grey_score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Gray_Score_Disp) {
            grey_score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Grey:
            if (this.type == Trash_Type.Caja_Leche || this.type == Trash_Type.Caja_Jugo || this.type == Trash_Type.Caja_Leche_Purp) {
              this.is_moving = false;
              update_move();
              if (grey_score != null) {
                grey_scored = true;
                grey_score.updateScore(1);
              }
            } else {
              // position = Vector2(position.x, position.y - 100);
            }
            // blue_scored = false;
            break;

          default:
            {}
        }
      }





      if (!scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
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
            if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Caja_Jugo ) {
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
