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

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;

    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(gameSize[0]*0.19 + 2*gameSize[1]*0.25, gameSize[0]*0.25 + gameSize[1]*0.5);
    size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    _yellow_score_val = Yellow_ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    // await add(_green_score_txt);
    await add(_yellow_score_val);
  }

  bool updateScore(int newScore) {
    this.yellow_score += newScore;
    this._yellow_score_val.yellow_score = this.yellow_score;
    return true;
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