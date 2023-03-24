import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Sol_Score_Disp extends PositionComponent with HasGameRef {
  late Sol_ScoreVal _sol_score_val;
  int sol_score = 0;

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

    position = Vector2(10, 20);
    size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    _sol_score_val = Sol_ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    // await add(_green_score_txt);
    await add(_sol_score_val);
  }

  bool sol_updateScore(int sol_newScore) {
    this.sol_score += sol_newScore;
    this._sol_score_val.sol_score = this.sol_score;
    return true;
  }
}

class Sol_ScoreVal extends TextComponent with HasGameRef {
  late int sol_score;

  Sol_ScoreVal({super.textRenderer, super.position}) : sol_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$sol_score', Vector2.zero());
  }
}