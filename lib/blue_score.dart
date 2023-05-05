import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

import 'basureros.dart';

class Blue_Score_Disp extends PositionComponent with HasGameRef {
  late Blue_ScoreVal _blue_score_val;
  int blue_score = 0;
  int i = 0;

  SpriteComponent BlueLevel1 = SpriteComponent();
  SpriteComponent BlueLevel2 = SpriteComponent();
  SpriteComponent BlueLevel3 = SpriteComponent();
  SpriteComponent BlueLevel4 = SpriteComponent();
  late double ratio = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = double.parse((gameSize[0]/gameSize[1]).toStringAsFixed(1));
    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );
    BlueLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(ratio*67, ratio*40)
      ..position = Vector2(ratio*381, ratio*410);

    add(BlueLevel1);

    BlueLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(ratio*70, ratio*40)
      ..position = Vector2(ratio*380, ratio*370);

    add(BlueLevel2);

    BlueLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(ratio*80, ratio*34)
      ..position = Vector2(ratio*375, ratio*336);

    add(BlueLevel3);

    BlueLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(ratio*79, ratio*37)
      ..position = Vector2(ratio*375, ratio*300);

    add(BlueLevel4);


    // await add(_green_score_txt);
  }

  bool blue_updateScore(int newScore) {
    this.blue_score += newScore;
    // this._blue_score_val.blue_score = this.blue_score;
      if (this.blue_score <= 40) {
        changeSpriteLevel();
      }

    return true;
  }
  void changeSpriteLevel() {
      if(blue_score <= 10){
        BlueLevel1.size.y = ratio*(40 - blue_score*4);
        if(blue_score == 10){
          BlueLevel1.removeFromParent();
        }
      }
      else if(blue_score <= 20){
        BlueLevel2.size.y = ratio*(40 - (blue_score - 10)*4);
        if(blue_score == 20){
          BlueLevel2.removeFromParent();
        }
      }
      else if(blue_score <= 30){
        BlueLevel3.size.y = ratio*(40 - (blue_score - 20)*3.4);
        if(blue_score == 30){
          BlueLevel3.removeFromParent();
        }
      }
      else if(blue_score <= 40){
        BlueLevel4.size.y = ratio*(40 - (blue_score - 30)*3.7);
        if(blue_score == 40){
          BlueLevel4.removeFromParent();
        }
      }
  }
}

class Blue_ScoreVal extends TextComponent with HasGameRef {
  late int blue_score;

  Blue_ScoreVal({super.textRenderer, super.position}) : blue_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$blue_score', Vector2.zero());
  }
}