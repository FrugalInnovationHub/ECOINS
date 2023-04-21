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
  late double ratio = 1;
  int i = 0;
  SpriteComponent YellowLevel1 = SpriteComponent();
  SpriteComponent YellowLevel2 = SpriteComponent();
  SpriteComponent YellowLevel3 = SpriteComponent();
  SpriteComponent YellowLevel4 = SpriteComponent();
  SpriteComponent YellowLock = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    double ratio = gameSize[0]/gameSize[1];
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


    // YellowLevel1
    //   ..sprite = await gameRef.loadSprite('01.png')
    //   ..size = Vector2(ratio*85, ratio*40)
    //   ..position = Vector2(ratio*417, ratio*400);
    //
    // add(YellowLevel1);
    //
    // YellowLevel2
    //   ..sprite = await gameRef.loadSprite('02.png')
    //   ..size = Vector2(ratio*88, ratio*40)
    //   ..position = Vector2(ratio*416, ratio*360);
    //
    // add(YellowLevel2);
    //
    // YellowLevel3
    //   ..sprite = await gameRef.loadSprite('03.png')
    //   ..size = Vector2(ratio*101, ratio*40)
    //   ..position = Vector2(ratio*410, ratio*320);
    //
    // add(YellowLevel3);
    //
    // YellowLevel4
    //   ..sprite = await gameRef.loadSprite('04.png')
    //   ..size = Vector2(ratio*99, ratio*40)
    //   ..position = Vector2(ratio*410, ratio*280);
    //
    // add(YellowLevel4);

    YellowLock
      ..sprite = await gameRef.loadSprite('Lock.png')
      ..size = Vector2(ratio*82, ratio*151)
      ..position = Vector2(ratio*399, ratio*309);

    add(YellowLock);


  }

  bool updateScore(int newScore) {
    this.yellow_score += newScore;
    // this._yellow_score_val.yellow_score = this.yellow_score;
    if (this.yellow_score < 10) {
      changeSpriteLevel();
    }
    return true;
  }
  void changeSpriteLevel() {
    i = i + 4;
    print(i);
    YellowLevel1.size = Vector2(ratio* 85, ratio*(40 - i));
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