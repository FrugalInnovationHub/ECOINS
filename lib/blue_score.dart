import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Blue_Score_Disp extends PositionComponent with HasGameRef {
  late Blue_ScoreVal _blue_score_val;
  int blue_score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(675, 500);
    size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    _blue_score_val = Blue_ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    // await add(_green_score_txt);
    await add(_blue_score_val);
  }

  bool blue_updateScore(int newScore) {
    this.blue_score += newScore;
    this._blue_score_val.blue_score = this.blue_score;
    return true;
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