import 'package:ecoins/trash_items.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:flutter/material.dart';

import 'basureros.dart';
import 'globals.dart';
import 'hbox_level2.dart';

class Blue_Score_Disp extends PositionComponent with HasGameRef {
  late Blue_ScoreVal _blue_score_val;
  int blue_score = 0;
  int i = 0;

  SpriteComponent BlueLevel1 = SpriteComponent();
  SpriteComponent BlueLevel2 = SpriteComponent();
  SpriteComponent BlueLevel3 = SpriteComponent();
  SpriteComponent BlueLevel4 = SpriteComponent();
  late var gameSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = gameRef.size;
    BlueLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(gameSize[0]*0.0865, gameSize[1]*0.088)
      ..position = Vector2(gameSize[0]*0.475, gameSize[1]*0.9);

    add(BlueLevel1);

    BlueLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(gameSize[0]*0.091, gameSize[1]*0.089)
      ..position = Vector2(gameSize[0]*0.473, gameSize[1]*0.8115);

    add(BlueLevel2);

    BlueLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(gameSize[0]*0.105, gameSize[1]*0.076)
      ..position = Vector2(gameSize[0]*0.467, gameSize[1]*0.736);

    add(BlueLevel3);

    BlueLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(gameSize[0]*0.102, gameSize[1]*0.082)
      ..position = Vector2(gameSize[0]*0.467, gameSize[1]*0.654);

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
        BlueLevel1.size.y = gameSize[1]*(0.088 - blue_score*0.0088);
        if(blue_score == 10){
          BlueLevel1.removeFromParent();
        }
      }
      else if(blue_score <= 20){
        BlueLevel2.size.y = gameSize[1]*(0.089 - (blue_score - 10)*0.0089);
        if(blue_score == 20){
          BlueLevel2.removeFromParent();
        }
      }
      else if(blue_score <= 30){
        BlueLevel3.size.y = gameSize[1]*(0.076 - (blue_score - 20)*0.0076);
        if(blue_score == 30){
          BlueLevel3.removeFromParent();
        }
      }
      else if(blue_score <= 40){
        BlueLevel4.size.y = gameSize[1]*(0.082 - (blue_score - 30)*0.0082);
        if(blue_score == 40){
          BlueLevel4.removeFromParent();
          // add(hbox_level2(size: Vector2(ratio,ratio*50), position: Vector2(-(ratio*50),ratio*100)));
          // add(hbox_level2(size: Vector2(ratio,ratio*50), position: Vector2(-(ratio*50),ratio)));
          FlameAudio.play(Globals.completeBin);
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