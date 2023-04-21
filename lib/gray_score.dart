import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Gray_Score_Disp extends PositionComponent with HasGameRef {
  late Gray_ScoreVal _gray_score_val;
  int gray_score = 0;
  late double ratio = 1;
  SpriteComponent GrayLock = SpriteComponent();

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
    //
    // position = Vector2(gameSize[0]*0.19 + 3*gameSize[1]*0.25, gameSize[0]*0.25 + gameSize[1]*0.5);
    // size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    // _gray_score_val = Gray_ScoreVal(
    //     textRenderer: _paint,
    //     position: Vector2(90, 1)
    // );
    //
    // // await add(_green_score_txt);
    // await add(_gray_score_val);
    GrayLock
      ..sprite = await gameRef.loadSprite('Lock.png')
      ..size = Vector2(ratio*80, ratio*150)
      ..position = Vector2(ratio*510, ratio*310);

    add(GrayLock);
  }

  bool updateScore(int newScore) {
    this.gray_score += newScore;
    this._gray_score_val.gray_score = this.gray_score;
    return true;
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