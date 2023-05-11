import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Gota_Score_Disp extends PositionComponent with HasGameRef {
  late Gota_ScoreVal _gota_score_val;
  int gota_score = 4;
  SpriteComponent GotaLevel1 = SpriteComponent();
  SpriteComponent GotaLevel2 = SpriteComponent();
  SpriteComponent GotaLevel3 = SpriteComponent();
  SpriteComponent GotaLevel4 = SpriteComponent();
  int g = 4;
  late double ratio = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = double.parse((gameSize[0]/gameSize[1]).toStringAsFixed(1));
    // final _style = TextStyle(
    //     color: BasicPalette.white.color,
    //     fontSize: 30.0,
    //     fontWeight: FontWeight.bold
    // );
    // final _paint = TextPaint(style: _style);
    //
    // position = Vector2(40, 500);
    // size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    // _gota_score_val = Gota_ScoreVal(
    //     textRenderer: _paint,
    //     position: Vector2(90, 1)
    // );

    // await add(_green_score_txt);
    // await add(_gota_score_val);
    GotaLevel1
      ..sprite = await gameRef.loadSprite('GOTA1.png')
      ..size = Vector2(ratio*57, ratio*19)
      ..position = Vector2(ratio*121, ratio*350);

    // add(GotaLevel1);

    GotaLevel2
      ..sprite = await gameRef.loadSprite('GOTA2.png')
      ..size = Vector2(ratio*57, ratio*16)
      ..position = Vector2(ratio*121, ratio*369);

    // add(GotaLevel2);

    GotaLevel3
      ..sprite = await gameRef.loadSprite('GOTA3.png')
      ..size = Vector2(ratio*57, ratio*18)
      ..position = Vector2(ratio*121, ratio*385);

    // add(GotaLevel3);

    GotaLevel4
      ..sprite = await gameRef.loadSprite('GOTA4.png')
      ..size = Vector2(ratio*57, ratio*16)
      ..position = Vector2(ratio*121, ratio*403);

    // add(GotaLevel4);
  }

  bool gota_updateScore(int gota_newScore) {
      this.gota_score += gota_newScore;
      changeSpriteLevel(1);
      return true;
  }
  int getGotaScore(){
    return this.g;
  }
  bool changeSpriteLevel(int level) {
    this.g += level;
    if(g == 1){
      GotaLevel4.removeFromParent();
    }
    else if(g == 2){
      GotaLevel3.removeFromParent();
    }
    else if(g == 3){
      GotaLevel2.removeFromParent();
    }
    else if(g == 4){
      GotaLevel1.removeFromParent();
    }
    return true;
  }

  bool recycleLevel(int add_level){
    this.gota_score -= 1;
    this.g -= add_level;
    if(g == 0){
      add(GotaLevel4);
      }
      else if(g == 1){
        add(GotaLevel3);
      }
      else if(g == 2){
        add(GotaLevel2);
      }
      else if(g == 3){
        add(GotaLevel1);
    }
    return true;
  }
}


class Gota_ScoreVal extends TextComponent with HasGameRef {
  late int gota_score;

  Gota_ScoreVal({super.textRenderer, super.position}) : gota_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$gota_score', Vector2.zero());
  }
}