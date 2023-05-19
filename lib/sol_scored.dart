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
  int sol_score = 4;
  int i = 4;

  SpriteComponent SolLevel1 = SpriteComponent();
  SpriteComponent SolLevel2 = SpriteComponent();
  SpriteComponent SolLevel3 = SpriteComponent();
  SpriteComponent SolLevel4 = SpriteComponent();


  // Sol_Score_Disp(int sol_score){
  //   this.sol_score = sol_score;
  // }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;

    // TextComponent _green_score_txt = TextComponent(
    //     text: 'Score: ',
    //     textRenderer: _paint,
    //     position: Vector2(0, 0)
    // );

    SolLevel1
      ..sprite = await gameRef.loadSprite('SOL1.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.04)
      ..position = Vector2(gameSize[0]*0.05, gameSize[1]*0.75);

    // add(SolLevel1);

    SolLevel2
      ..sprite = await gameRef.loadSprite('SOL2.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.035)
      ..position = Vector2(gameSize[0]*0.05, gameSize[1]*0.79);

    // add(SolLevel2);

    SolLevel3
      ..sprite = await gameRef.loadSprite('SOL3.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.04)
      ..position = Vector2(gameSize[0]*0.05, gameSize[1]*0.825);

    // add(SolLevel3);

    SolLevel4
      ..sprite = await gameRef.loadSprite('SOL4.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.035)
      ..position = Vector2(gameSize[0]*0.05, gameSize[1]*0.865);

    // add(SolLevel4);

    // await add(_green_score_txt);
    // await add(_sol_score_val);
  }

  bool sol_updateScore(int sol_newScore) {
      this.sol_score += sol_newScore;
      changeSpriteLevel(1);
      return true;
  }

  void changeSpriteLevel(int level) {
    this.i += level;
    if(i == 1){
      SolLevel4.removeFromParent();
    }
    else if(i == 2){
      SolLevel3.removeFromParent();
    }
    else if(i == 3){
      SolLevel2.removeFromParent();
    }
    else if(i == 4){
      SolLevel1.removeFromParent();
    }
  }
  int getSolScore(){
    return this.i;
  }

  bool recycleLevel(int add_level){
    this.sol_score -= 1;
    this.i -= add_level;
    if(i == 0){
      add(SolLevel4);
    }
    else if(i == 1){
      add(SolLevel3);
    }
    else if(i == 2){
      add(SolLevel2);
    }
    else if(i == 3){
      add(SolLevel1);
    }
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