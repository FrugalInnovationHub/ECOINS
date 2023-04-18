import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

class Gota_Score_Disp extends PositionComponent with HasGameRef {
  late Gota_ScoreVal _gota_score_val;
  int gota_score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: 30.0,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(40, 500);
    size = Vector2(30, 40);

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    _gota_score_val = Gota_ScoreVal(
        textRenderer: _paint,
        position: Vector2(90, 1)
    );

    // await add(_green_score_txt);
    await add(_gota_score_val);
  }

  bool gota_updateScore(int gota_newScore) {
    this._gota_score_val.gota_score += gota_newScore;
    // print(this._sol_score_val.sol_score);
    return true;
  }
}

class Gota_ScoreVal extends TextComponent with HasGameRef {
  late int gota_score;

  Gota_ScoreVal({super.textRenderer, super.position}) : gota_score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$gota_score', Vector2.zero());
  }
}