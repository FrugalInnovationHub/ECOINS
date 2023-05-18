import 'package:ecoins/components/basuresos_lock.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Yellow_Score_Disp extends PositionComponent with HasGameRef {
  late Yellow_ScoreVal _yellow_score_val;
  int yellow_score = 0;
  int i = 0;
  SpriteComponent YellowLevel1 = SpriteComponent();
  SpriteComponent YellowLevel2 = SpriteComponent();
  SpriteComponent YellowLevel3 = SpriteComponent();
  SpriteComponent YellowLevel4 = SpriteComponent();
  late var gameSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = gameRef.size;
    // final _style = TextStyle(
    //     color: BasicPalette.white.color,
    //     fontSize: 30.0,
    //     fontWeight: FontWeight.bold
    // );
    // final _paint = TextPaint(style: _style);

    // position = Vector2(gameSize[0]*0.19 + 2*gameSize[1]*0.25, gameSize[0]*0.25 + gameSize[1]*0.5);
    // size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    // _yellow_score_val = Yellow_ScoreVal(
    //     textRenderer: _paint,
    //     position: Vector2(90, 1)
    // );

    // await add(_green_score_txt);
    // await add(_yellow_score_val);


    YellowLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.088)
      ..position = Vector2(gameSize[0]*0.612, gameSize[1]*0.9);

    // add(YellowLevel1);

    YellowLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(gameSize[0]*0.095, gameSize[1]*0.089)
      ..position = Vector2(gameSize[0]*0.61, gameSize[1]*0.8115);

    // add(YellowLevel2);

    YellowLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(gameSize[0]*0.106, gameSize[1]*0.076)
      ..position = Vector2(gameSize[0]*0.605, gameSize[1]*0.736);

    // add(YellowLevel3);

    YellowLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(gameSize[0]*0.104, gameSize[1]*0.082)
      ..position = Vector2(gameSize[0]*0.605, gameSize[1]*0.654);

    // add(YellowLevel4);

  }
  void addLevels(){
    add(YellowLevel1);
    add(YellowLevel2);
    add(YellowLevel3);
    add(YellowLevel4);
  }

  bool updateScore(int newScore) {
    this.yellow_score += newScore;
    // this._yellow_score_val.yellow_score = this.yellow_score;
    if (this.yellow_score <= 40) {
      changeSpriteLevel();
    }
    return true;
  }

  void changeSpriteLevel() {
    if(yellow_score <= 10){
      YellowLevel1.size.y = gameSize[1]*(0.088 - yellow_score*0.0088);
      if(yellow_score == 10){
        YellowLevel1.removeFromParent();
      }
    }
    else if(yellow_score <= 20){
      YellowLevel2.size.y = gameSize[1]*(0.089 - (yellow_score - 10)*0.0089);
      if(yellow_score == 20){
        YellowLevel2.removeFromParent();
      }
    }
    else if(yellow_score <= 30){
      YellowLevel3.size.y = gameSize[1]*(0.076 - (yellow_score - 10)*0.0076);
      if(yellow_score == 30){
        YellowLevel3.removeFromParent();
      }
    }
    else if(yellow_score <= 40){
      YellowLevel4.size.y = gameSize[1]*(0.082 - (yellow_score - 10)*0.0082);
      if(yellow_score == 40){
        YellowLevel4.removeFromParent();
      }
    }
  }
}

class Yellow_ScoreVal extends TextComponent with HasGameRef {
  late int yellow_score;

  Yellow_ScoreVal({super.textRenderer, super.position}) : yellow_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$yellow_score', Vector2.zero());
  }
}