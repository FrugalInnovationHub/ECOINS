import 'package:ecoins/gray_score.dart';
import 'package:ecoins/sol_scored.dart';
import 'package:ecoins/yellow_score.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';

import 'banda_t_hole.dart';
import 'basureros.dart';
import 'basureros_hbox.dart';
import 'blue_score.dart';
import 'game.dart';
import 'globals.dart';
import 'gota_scored.dart';
import 'green_score.dart';
import 'hbox_level3.dart';
import 'score_disp.dart';

enum Trash_Type implements Comparable<Trash_Type> {
  Botella_Plastico(type: "Plastico", src: 'botella_plastico.png', size: [0.025, 0.085], priority: 3),
  Plastic_BOTTLE(type: "Plastico", src: 'Plastic_BOTTLE.png', size: [0.025, 0.095], priority: 3),
  Botella_Refresco(type: "Plastico", src: 'Botella_Refresco.png', size: [0.025, 0.095], priority: 3),
  Bola_Papel(type: "Paper", src: 'Bola_papel.png', size: [0.035, 0.065], priority: 3),
  Caja_Carton(type: "Paper", src: 'Caja_Carton.png', size: [0.07, 0.095], priority: 1),
  Botella_Agua(type: "Plastico", src: 'Botella_Agua.png', size: [0.025, 0.095], priority: 3),
  Botella_Agua_Grande(type: "Plastico", src: 'Botella_Agua_Grande.png', size: [0.035, 0.095], priority: 1),
  Botella_Jabon(type: "Plastico", src: 'Botella_jabon.png', size: [0.03, 0.095], priority: 2),
  Cilindro_Papel(type: "Paper", src: 'Cilindro_papel.png', size: [0.025, 0.095], priority: 2),
  LATA_2(type: "Aluminio", src: 'LATA_2.png', size: [0.025, 0.095], priority: 3),
  LATA_3(type: "Aluminio", src: 'LATA_3.png', size: [0.025, 0.095], priority: 3),
  Lata_aluminio(type: "Aluminio", src: 'Lata_aluminio.png', size: [0.025, 0.095], priority: 2);


  const Trash_Type({
    required this.type,
    required this.src,
    required this.size,
    required this.priority
  });

  final type;
  final src;
  final size;
  final priority;

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
  // late final ratio;
  late OpacityEffect h_opacity_effect;
  late RemoveEffect h_remove_effect;
  late final category;
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
  int div = 0;
  double speed;
  late OpacityEffect h_opacity_blink_effect;
  late var gameSize;
  late MoveEffect h_move_effect_new;


  Trash_Item(Trash_Type type, double delay, double y_loc, int count, double speed) :
        this.type = type, this.delay = delay, this.y_loc = y_loc, this.count = count, this.speed = speed;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = gameRef.size;
    // ratio = double.parse((gameRef.size[0]/gameRef.size[1]).toStringAsFixed(1));
    category = type.type;
    y_loc = y_loc - gameSize[1]*(type.size[1] - 0.01);
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-(gameSize[0]*0.08), y_loc);
    size = Vector2(gameSize[0]*type.size[0], gameSize[1]*type.size[1]);
    priority = type.priority;

    add(RectangleHitbox(isSolid: true));
    h_opacity_effect = OpacityEffect.to(0, EffectController(duration: 0.75, startDelay: 3));
    h_opacity_blink_effect = OpacityEffect.to(2, EffectController(duration: 1, repeatCount: 3, startDelay: 5));
    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, y_loc),
      EffectController(
        startDelay: delay,
        duration: speed,
        infinite: true,
        alternate: true
      ),
    );
    h_remove_effect = RemoveEffect(delay: 4);

    h_move_effect_new = MoveEffect.to(
            Vector2(size[0], y_loc),
            EffectController(
                startDelay: 0,
                duration: speed,
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
      if((gameSize[1]*0.11 - gameSize[1]*(type.size[1] - 0.01)) == position.y) {
        position = Vector2(position.x, gameSize[1]*0.31 - gameSize[1]*(type.size[1] - 0.01));
        FlameAudio.play(Globals.itemsClick);
      }
      else if((gameSize[1]*0.31 - gameSize[1]*(type.size[1] - 0.01)) == position.y) {
        position = Vector2(position.x, gameSize[1]*0.505 - gameSize[1]*(type.size[1] - 0.01));
        FlameAudio.play(Globals.itemsClick);
      }
      else{
        position = Vector2(position.x, gameSize[1]*0.7 - gameSize[1]*type.size[1]);
        // FlameAudio.play(Globals.itemsClick);
      }
    }
    return false;
  }

  update_move() {
    if(is_moving == true) {
      add(h_move_effect);
    } else {
      h_move_effect.removeFromParent();
      h_move_effect_new.removeFromParent();
      Future.delayed(Duration(seconds: 2), () {
        removeFromParent();      });
    }
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    final allPositionComponents = parent.children.query<PositionComponent>();
    Gota_Score_Disp ?gota_score_disp;
    Sol_Score_Disp ?sol_score_disp;
    Sol_Score_Disp ?get_Solscore;
    Gota_Score_Disp ?get_Gotascore;
    int solScore = 0;
    int gotaScore = 0;
    Score_Disp ?score;
    for (PositionComponent p in allPositionComponents){
      if (p is Gota_Score_Disp) {
        gota_score_disp = p;
      }
      if (p is Sol_Score_Disp) {
        sol_score_disp = p;
      }
      if (p is Sol_Score_Disp) {
        get_Solscore = p;
      }
      if (p is Gota_Score_Disp) {
        get_Gotascore = p;
      }
      if (p is Score_Disp) {
        score = p;
      }
    }
    if(get_Solscore != null){
      solScore = get_Solscore.getSolScore();
    }
    if(get_Gotascore != null){
      gotaScore = get_Gotascore.getGotaScore();
    }
    if (other is Banda_T_Hole) {
      if(other.hole_no == 0) {
        is_colliding = true;
      }
      else if(((other.hole_no == 1 && this.type.type == "Plastico") || (other.hole_no == 2 && this.type.type == "Aluminio") || (other.hole_no == 3 && this.type.type == "Paper" )) && solScore > 0 && gotaScore > 0) {
        is_colliding = true;
      }

    }

    // else if(other is hbox_level2){
    //   print("this is hbox l2");
    //   h_move_effect.removeFromParent();
    //   h_move_effect_new = MoveEffect.to(
    //     Vector2(size[0], y_loc),
    //     EffectController(
    //         startDelay: 0,
    //         duration: speed,
    //         infinite: true,
    //         alternate: true
    //     ),
    //   );
    //   add(h_move_effect_new);
    // }

    else if (other is Trash_Item ) {
      // position = Vector2(position.x - 20 , position.y);
    } else if (other is Basureros_HBox) {


      if (!blue_scored && type.type == "Plastico") {
        Blue_Score_Disp ?blue_score;

        for (PositionComponent p in allPositionComponents) {
          if (p is Blue_Score_Disp) {
            blue_score = p;
          }
        }

        if(solScore > 0 && gotaScore > 0){
          switch (other.type) {
            case BHBox_Type.Blue:
              if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Botella_Agua || this.type == Trash_Type.Botella_Agua_Grande || this.type == Trash_Type.Botella_Jabon || this.type == Trash_Type.Botella_Refresco || this.type == Trash_Type.Plastic_BOTTLE) {
                this.is_moving = false;
                update_move();
                if (blue_score != null &&
                    gota_score_disp != null &&
                    sol_score_disp != null && score != null) {
                  blue_scored = true;
                  score.updateScore(10);
                  blue_score.blue_updateScore(10);
                  gota_score_disp.recycleLevel(1);
                  sol_score_disp.recycleLevel(1);
                  add(h_opacity_effect);
                  add(h_remove_effect);
                  FlameAudio.play(Globals.items_inside_container);
                }
              } else {
                position = Vector2(position.x, gameSize[1]*0.505 );
              }
              // blue_scored = false;
              break;
              default:
              {}
          }
        } else{
          position = Vector2(position.x, gameSize[1]*0.505);
        }
      }
      if (!yellow_scored && type.type == "Aluminio") {
        Yellow_Score_Disp ?yellow_score;
        for (PositionComponent p in allPositionComponents) {
          if (p is Yellow_Score_Disp) {
            yellow_score = p;
          }
        }
        if(solScore > 0 && gotaScore > 0) {
          switch (other.type) {
            case BHBox_Type.Yellow:
              if (this.type == Trash_Type.Lata_aluminio ||
                  this.type == Trash_Type.LATA_2 ||
                  this.type == Trash_Type.LATA_3) {
                this.is_moving = false;
                update_move();
                if (yellow_score != null && gota_score_disp != null &&
                sol_score_disp != null && score != null) {
                  yellow_scored = true;
                  score.updateScore(10);
                  yellow_score.updateScore(10);
                  gota_score_disp.recycleLevel(1);
                  sol_score_disp.recycleLevel(1);
                  add(h_opacity_effect);
                  add(h_remove_effect);
                  FlameAudio.play(Globals.items_inside_container);
                }
              } else {
                position = Vector2(position.x, gameSize[1]*0.505);
              }
              break;

            default:
              {}
          }
        }
        else{
          position = Vector2(position.x, gameSize[1]*0.505);
        }
      }

      if (!grey_scored && type.type == "Paper") {
        Gray_Score_Disp ?grey_score;
        speed = 5;
        for (PositionComponent p in allPositionComponents) {
          if (p is Gray_Score_Disp) {
            grey_score = p;
          }
        }
        if(solScore > 0 && gotaScore > 0) {
          switch (other.type) {
            case BHBox_Type.Grey:
              if (this.type == Trash_Type.Caja_Carton ||
                  this.type == Trash_Type.Cilindro_Papel ||
                  this.type == Trash_Type.Bola_Papel) {
                this.is_moving = false;
                update_move();
                if (grey_score != null && gota_score_disp != null &&
                    sol_score_disp != null && score != null) {
                  grey_scored = true;
                  score.updateScore(10);
                  grey_score.updateScore(10);
                  gota_score_disp.recycleLevel(1);
                  sol_score_disp.recycleLevel(1);
                  add(h_opacity_effect);
                  add(h_remove_effect);
                  FlameAudio.play(Globals.items_inside_container);
                }
              } else {
                position = Vector2(position.x, gameSize[1]*0.505);
              }
              // blue_scored = false;
              break;

            default:
              {}
          }
        }
        else{
          position = Vector2(position.x, gameSize[1]*0.505);
        }
      }


    //   if (!scored) {
    //     final allPositionComponents = parent.children.query<PositionComponent>();
    //     Score_Disp ?score;
    //     for (PositionComponent p in allPositionComponents) {
    //       if (p is Score_Disp) {
    //         score = p;
    //       }
    //     }
    //     switch (other.type) {
    //       case BHBox_Type.Blue:
    //         if (this.type == Trash_Type.Botella_Plastico || this.type == Trash_Type.Botella_Agua || this.type == Trash_Type.Botella_Agua_Grande || this.type == Trash_Type.Botella_Jabon || this.type == Trash_Type.Botella_Refresco || this.type == Trash_Type.Plastic_BOTTLE) {
    //           this.is_moving = false;
    //           update_move();
    //           if (score != null) {
    //             scored = true;
    //             score.updateScore(1);
    //             // add(h_opacity_effect);
    //           }
    //         } else {
    //           // position = Vector2(position.x, position.y - ratio*100);
    //         }
    //         // removeFromParent();
    //         break;
    //       case BHBox_Type.Yellow:
    //         if (this.type == Trash_Type.Lata_aluminio || this.type == Trash_Type.LATA_2 || this.type == Trash_Type.LATA_3) {
    //           this.is_moving = false;
    //           update_move();
    //           if (score != null) {
    //             scored = true;
    //             score.updateScore(1);
    //             // add(h_opacity_effect);
    //           }
    //         } else {
    //         position = Vector2(position.x, position.y - ratio*100);
    //         }
    //         // removeFromParent();
    //         break;
    //       case BHBox_Type.Yellow:
    //       // if(this.type != Trash_Type.Botella_Plastico) {
    //         position = Vector2(position.x, position.y - 100);
    //         // }
    //         break;
    //       case BHBox_Type.Grey:
    //         if (
    //             this.type == Trash_Type.Bola_Papel ||
    //             this.type == Trash_Type.Caja_Carton ||
    //             this.type == Trash_Type.Cilindro_Papel
    //         ) {
    //           this.is_moving = false;
    //           update_move();
    //           if (score != null) {
    //             scored = true;
    //             score.updateScore(1);
    //             // add(h_opacity_effect);
    //           }
    //         } else {
    //           position = Vector2(position.x, position.y - ratio*100);
    //         }
    //         break;
    //       default:
    //         {}
    //     }
    //   } else {
    //
    //   }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Banda_T_Hole) {
      is_colliding = false;
    }
    else if(other is hbox_level3){
      if(count > 2) {
        removeFromParent();
      }
      // else if(other is hbox_level2){
      //   h_move_effect.removeFromParent();
      //   h_move_effect_new = MoveEffect.to(
      //     Vector2(size[0], y_loc),
      //     EffectController(
      //         startDelay: 0,
      //         duration: speed,
      //         infinite: true,
      //         alternate: true
      //     ),
      //   );
      //   add(h_move_effect_new);
      // }
      // else if(other is hbox_level1){
      //   h_move_effect.removeFromParent();
      //   h_move_effect_new = MoveEffect.to(
      //     Vector2(size[0], y_loc),
      //     EffectController(
      //         startDelay: 0,
      //         duration: speed,
      //         infinite: true,
      //         alternate: true
      //     ),
      //   );
      //   add(h_move_effect_new);
      // }
      else {
        count += 1;
        div += 2;
        h_opacity_blink_effect = OpacityEffect.to(2, EffectController(duration: 4/div, repeatCount: 30, startDelay: 1));
        add(h_opacity_blink_effect);
      }
    }
  }

}
