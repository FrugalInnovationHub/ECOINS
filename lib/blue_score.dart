import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

import 'package:flutter/material.dart';

import 'basureros.dart';

class Blue_Score_Disp extends PositionComponent with HasGameRef {
  late Blue_ScoreVal _blue_score_val;
  int blue_score = 0;
  int i = 0;

  SpriteComponent BlueLevel1 = SpriteComponent();
  SpriteComponent BlueLevel2 = SpriteComponent();
  SpriteComponent BlueLevel3 = SpriteComponent();
  SpriteComponent BlueLevel4 = SpriteComponent();
  late double ratio = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    ratio = gameSize[0]/gameSize[1];
    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );
    BlueLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(ratio*67, ratio*40)
      ..position = Vector2(ratio*296, ratio*420);

    add(BlueLevel1);

    BlueLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(ratio*70, ratio*40)
      ..position = Vector2(ratio*295, ratio*380);

    add(BlueLevel2);

    BlueLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(ratio*80, ratio*34)
      ..position = Vector2(ratio*290, ratio*346);

    add(BlueLevel3);

    BlueLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(ratio*79, ratio*37)
      ..position = Vector2(ratio*290, ratio*310);

    add(BlueLevel4);


    // await add(_green_score_txt);
  }

  bool blue_updateScore(int newScore) {
    this.blue_score += newScore;
    // this._blue_score_val.blue_score = this.blue_score;
      if (this.blue_score <= 10) {
        changeSpriteLevel();
      }

    return true;
  }
  void changeSpriteLevel() {
      i = i + 4;
      print(i);
      BlueLevel1.size.y = ratio*(40 - i);
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