import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Score_Disp extends SpriteComponent with HasGameRef {
  late ScoreVal _score_val;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var ratio = gameRef.size[0]/gameRef.size[1];

    sprite = await gameRef.loadSprite("SCORE.png");

    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: ratio*30,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(ratio*725, ratio* 325);
    size = Vector2(ratio*75, ratio*100);

    _score_val = ScoreVal(
        textRenderer: _paint,
        position: Vector2(ratio*30, ratio*35)
    );

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