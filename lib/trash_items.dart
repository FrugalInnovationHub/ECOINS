import 'package:ecoins/gray_score.dart';
import 'package:ecoins/yellow_score.dart';
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
import 'hbox_level3.dart';
import 'score_disp.dart';

enum Trash_Type implements Comparable<Trash_Type> {
  Botella_Plastico(src: 'botella_plastico.png', size: [20, 45]),
  Plastic_BOTTLE(src: 'Plastic_BOTTLE.png', size: [20, 45]),
  Botella_Refresco(src: 'Botella_Refresco.png', size: [20, 45]),
  Bola_Papel(src: 'Bola_papel.png', size: [30, 30]),
  Caja_Carton(src: 'Caja_Carton.png', size: [60, 45]),
  Botella_Agua(src: 'Botella_Agua.png', size: [20, 45]),
  Botella_Agua_Grande(src: 'Botella_Agua_Grande.png', size: [30, 45]),
  Botella_Jabon(src: 'Botella_jabon.png', size: [25, 45]),
  Cilindro_Papel(src: 'Cilindro_papel.png', size: [20, 45]),
  LATA_2(src: 'LATA_2.png', size: [20, 45]),
  LATA_3(src: 'LATA_3.png', size: [20, 45]),
  Lata_aluminio(src: 'Lata_aluminio.png', size: [20, 45]);


  const Trash_Type({
    required this.src,
    required this.size
  });

  final src;
  final size;

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
  late final ratio;
  late OpacityEffect h_opacity_effect;
  bool is_moving = true;
  bool is_colliding = false;
  bool scored = false;
  bool yellow_scored = false;
  bool blue_scored = false;
  bool grey_scored = false;
  Trash_Type type;
  double delay;
  double y_loc;
  int count;


  Trash_Item(Trash_Type type, double delay, double y_loc, int count) :
        this.type = type, this.delay = delay, this.y_loc = y_loc, this.count = count;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    ratio = gameRef.size[0]/gameRef.size[1];
    y_loc = y_loc - ratio*type.size[1];
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-(ratio*60), y_loc);
    size = Vector2(ratio*type.size[0], ratio*type.size[1]);

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
      if((ratio*50 - ratio*type.size[1]) == position.y) {
        position = Vector2(position.x, ratio*150 - ratio*type.size[1]);
      }
      else if((ratio*150 - ratio*type.size[1]) == position.y) {
        position = Vector2(position.x, ratio*250 - ratio*type.size[1]);
      }
      else{
        position = Vector2(position.x, ratio*350 - ratio*type.size[1]);
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
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {

    if (other is Banda_T_Hole) {
      is_colliding = true;
    } else if (other is Trash_Item ) {
      // position = Vector2(position.x - 20 , position.y);
    }
    else if(other is hbox_level3){
      count += 1;
      if(count == 6){
        add(h_opacity_effect);
        h_move_effect.removeFromParent();
      }
    }
    else if (other is Basureros_HBox) {
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
            if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Botella_Agua || this.type == Trash_Type.Botella_Agua_Grande || this.type == Trash_Type.Botella_Jabon || this.type == Trash_Type.Botella_Refresco || this.type == Trash_Type.Plastic_BOTTLE) {
              this.is_moving = false;
              update_move();
              if (blue_score != null) {
                blue_scored = true;
                blue_score.blue_updateScore(1);
                add(h_opacity_effect);
              }
            } else {
              // position = Vector2(position.x, position.y - ratio*100);
            }
            // blue_scored = false;
            break;

          default:
            {}
        }
      }
      if (!yellow_scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
        Yellow_Score_Disp ?yellow_score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Yellow_Score_Disp) {
            yellow_score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Yellow:
            if (this.type == Trash_Type.Lata_aluminio || this.type == Trash_Type.LATA_2 || this.type == Trash_Type.LATA_3) {
              this.is_moving = false;
              update_move();
              if (yellow_score != null) {
                yellow_scored = true;
                yellow_score.updateScore(1);
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
            if (this.type == Trash_Type.Caja_Carton || this.type == Trash_Type.Cilindro_Papel || this.type == Trash_Type.Bola_Papel) {
              this.is_moving = false;
              update_move();
              if (grey_score != null) {
                grey_scored = true;
                grey_score.updateScore(1);
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





      if (!scored) {
        final allPositionComponents = parent.children.query<PositionComponent>();
        Score_Disp ?score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Score_Disp) {
            score = p;
          }
        }
        switch (other.type) {
          case BHBox_Type.Blue:
            if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Botella_Agua || this.type == Trash_Type.Botella_Agua_Grande || this.type == Trash_Type.Botella_Jabon || this.type == Trash_Type.Botella_Refresco || this.type == Trash_Type.Plastic_BOTTLE) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
                // add(h_opacity_effect);
              }
            } else {
              position = Vector2(position.x, position.y - ratio*100);
            }
            // removeFromParent();
            break;
          case BHBox_Type.Yellow:
            if (this.type == Trash_Type.Lata_aluminio || this.type == Trash_Type.LATA_2 || this.type == Trash_Type.LATA_3) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
                // add(h_opacity_effect);
              }
            } else {
            position = Vector2(position.x, position.y - ratio*100);
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
                this.type == Trash_Type.Bola_Papel ||
                this.type == Trash_Type.Caja_Carton ||
                this.type == Trash_Type.Cilindro_Papel
            ) {
              this.is_moving = false;
              update_move();
              if (score != null) {
                scored = true;
                score.updateScore(1);
                // add(h_opacity_effect);
              }
            } else {
              position = Vector2(position.x, position.y - ratio*100);
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
