import 'package:ecoins/components/basuresos_lock.dart';
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

import 'globals.dart';

class Gray_Score_Disp extends PositionComponent with HasGameRef {
  late Gray_ScoreVal _gray_score_val;
  int gray_score = 0;
  late double ratio = 1;
  SpriteComponent GrayLevel1 = SpriteComponent();
  SpriteComponent GrayLevel2 = SpriteComponent();
  SpriteComponent GrayLevel3 = SpriteComponent();
  SpriteComponent GrayLevel4 = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = double.parse((gameSize[0]/gameSize[1]).toStringAsFixed(1));


    GrayLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(ratio*67, ratio*40)
      ..position = Vector2(ratio*601, ratio*410);

    // add(GrayLevel1);

    GrayLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(ratio*70, ratio*40)
      ..position = Vector2(ratio*600, ratio*370);

    // add(GrayLevel2);

    GrayLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(ratio*80, ratio*34)
      ..position = Vector2(ratio*595, ratio*336);

    // add(GrayLevel3);

    GrayLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(ratio*79, ratio*37)
      ..position = Vector2(ratio*595, ratio*300);

    // add(GrayLevel4);
  }

  void addLevels(){
    add(GrayLevel1);
    add(GrayLevel2);
    add(GrayLevel3);
    add(GrayLevel4);
  }

  bool updateScore(int newScore) {
    this.gray_score += newScore;
    // this._gray_score_val.gray_score = this.gray_score;
    if (this.gray_score <= 40) {
      changeSpriteLevel();
    }
    return true;
  }

  void changeSpriteLevel() {
    if(gray_score <= 10){
      GrayLevel1.size.y = ratio*(40 - gray_score*4);
      if(gray_score == 10){
        GrayLevel1.removeFromParent();
      }
    }
    else if(gray_score <= 20){
      GrayLevel2.size.y = ratio*(40 - (gray_score - 10)*4);
      if(gray_score == 20){
        GrayLevel2.removeFromParent();
      }
    }
    else if(gray_score <= 30){
      GrayLevel3.size.y = ratio*(40 - (gray_score - 20)*3.4);
      if(gray_score == 30){
        GrayLevel3.removeFromParent();
      }
    }
    else if(gray_score <= 40){
      GrayLevel4.size.y = ratio*(40 - (gray_score - 30)*3.7);
      if(gray_score == 40){
        GrayLevel4.removeFromParent();
        FlameAudio.play(Globals.gameComplete);
      }
    }
  }
}

class Gray_ScoreVal extends TextComponent with HasGameRef {
  late int gray_score;

  Gray_ScoreVal({super.textRenderer, super.position}) : gray_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$gray_score', Vector2.zero());
  }
}