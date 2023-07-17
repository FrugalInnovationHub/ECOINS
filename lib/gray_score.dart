import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'globals.dart';

class Gray_Score_Disp extends PositionComponent with HasGameRef {
  int gray_score = 0;
  SpriteComponent GrayLevel1 = SpriteComponent();
  SpriteComponent GrayLevel2 = SpriteComponent();
  SpriteComponent GrayLevel3 = SpriteComponent();
  SpriteComponent GrayLevel4 = SpriteComponent();
  late var gameSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = gameRef.size;


    GrayLevel1
      ..sprite = await gameRef.loadSprite('01.png')
      ..size = Vector2(gameSize[0]*0.09, gameSize[1]*0.088)
      ..position = Vector2(gameSize[0]*0.746, gameSize[1]*0.9);

    // add(GrayLevel1);

    GrayLevel2
      ..sprite = await gameRef.loadSprite('02.png')
      ..size = Vector2(gameSize[0]*0.094, gameSize[1]*0.089)
      ..position = Vector2(gameSize[0]*0.745, gameSize[1]*0.8115);

    // add(GrayLevel2);

    GrayLevel3
      ..sprite = await gameRef.loadSprite('03.png')
      ..size = Vector2(gameSize[0]*0.107, gameSize[1]*0.076)
      ..position = Vector2(gameSize[0]*0.739, gameSize[1]*0.736);

    // add(GrayLevel3);

    GrayLevel4
      ..sprite = await gameRef.loadSprite('04.png')
      ..size = Vector2(gameSize[0]*0.104, gameSize[1]*0.082)
      ..position = Vector2(gameSize[0]*0.74, gameSize[1]*0.654);

    // add(GrayLevel4);
  }

  void addLevels(){
    add(GrayLevel1);
    add(GrayLevel2);
    add(GrayLevel3);
    add(GrayLevel4);
  }

  bool updateScore(int newScore) {
    this.gray_score += newScore;
    // this._gray_score_val.gray_score = this.gray_score;
    if (this.gray_score <= 40) {
      changeSpriteLevel();
    }
    return true;
  }

  void changeSpriteLevel() {
    if(gray_score <= 10){
      GrayLevel1.size.y = gameSize[1]*(0.088 - gray_score*0.0088);
      if(gray_score == 10){
        GrayLevel1.removeFromParent();
      }
    }
    else if(gray_score <= 20){
      GrayLevel2.size.y = gameSize[1]*(0.089 - (gray_score - 10)*0.0089);
      if(gray_score == 20){
        GrayLevel2.removeFromParent();
      }
    }
    else if(gray_score <= 30){
      GrayLevel3.size.y = gameSize[1]*(0.076 - (gray_score - 20)*0.0076);
      if(gray_score == 30){
        GrayLevel3.removeFromParent();
      }
    }
    else if(gray_score <= 40){
      GrayLevel4.size.y = gameSize[1]*(0.082 - (gray_score - 30)*0.0082);
      if(gray_score == 40){
        GrayLevel4.removeFromParent();
        FlameAudio.play(Globals.gameComplete);
      }
    }
  }
}