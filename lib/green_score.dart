import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Green_Score_Disp extends PositionComponent with HasGameRef {
  late Green_ScoreVal _green_score_val;
  int green_score = 0;

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

    position = Vector2(gameSize[0]/4, gameSize[0]/4 + gameSize[1]/2);
    size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    _green_score_val = Green_ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    // await add(_green_score_txt);
    await add(_green_score_val);
  }

  bool green_updateScore(int green_newScore) {
    this.green_score += green_newScore;
    this._green_score_val.green_score = this.green_score;
    return true;
  }
}

class Green_ScoreVal extends TextComponent with HasGameRef {
  late int green_score;

  Green_ScoreVal({super.textRenderer, super.position}) : green_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$green_score', Vector2.zero());
  }
}