import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Score_Disp extends PositionComponent with HasGameRef {
  late ScoreVal _score_val;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final _style = TextStyle(
        color: BasicPalette.black.color,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(40, 0);
    size = Vector2(30, 40);

    TextComponent _score_txt = TextComponent(
        text: 'Score: ',
        textRenderer: _paint,
        position: Vector2(0, 0)
    );

    _score_val = ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    await add(_score_txt);
    await add(_score_val);
  }

  bool updateScore(int newScore) {
    this.score += newScore;
    this._score_val.score = this.score;
    return true;
  }

}

class ScoreVal extends TextComponent with HasGameRef {
  late int score;

  ScoreVal({super.textRenderer, super.position}) : score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$score', Vector2.zero());
  }
}