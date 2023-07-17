import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';

import 'package:flutter/material.dart';

class Score_Disp extends SpriteComponent with HasGameRef {
  late ScoreVal _score_val;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("SCORE.png");

    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: gameRef.size[0]*0.03,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    position = Vector2(gameRef.size[0]*0.875, gameRef.size[1]* 0.725);
    size = Vector2(gameRef.size[0]*0.09, gameRef.size[1]*0.21);
    _score_val = ScoreVal(
        textRenderer: _paint,
        position: Vector2(gameRef.size[0]*0.045, gameRef.size[1]*0.1)
    );

    await add(_score_val);
  }

  // @override
  // void onGameResize(Vector2 size) {
  //   // TODO: implement onGameResize
  //   super.onGameResize(size);
  //   this.position = Vector2(size[0]*0.875, size[1]* 0.725);
  //   this.size = Vector2(size[0]*0.09, size[1]*0.21);
  // }
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
    textRenderer.render(canvas, '$score', Vector2.zero(), anchor: Anchor.center);
  }
}