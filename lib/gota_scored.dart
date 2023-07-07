import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';

class Gota_Score_Disp extends PositionComponent with HasGameRef {
  int gota_score = 4;
  SpriteComponent GotaLevel1 = SpriteComponent();
  SpriteComponent GotaLevel2 = SpriteComponent();
  SpriteComponent GotaLevel3 = SpriteComponent();
  SpriteComponent GotaLevel4 = SpriteComponent();
  int g = 4;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var gameSize = gameRef.size;
    GotaLevel1
      ..sprite = await gameRef.loadSprite('GOTA1.png')
      ..size = Vector2(gameSize[0]*0.071, gameSize[1]*0.0401)
      ..position = Vector2(gameSize[0]*0.154, gameSize[1]*0.75);

    // add(GotaLevel1);

    GotaLevel2
      ..sprite = await gameRef.loadSprite('GOTA2.png')
      ..size = Vector2(gameSize[0]*0.071, gameSize[1]*0.0351)
      ..position = Vector2(gameSize[0]*0.154, gameSize[1]*0.79);

    // add(GotaLevel2);

    GotaLevel3
      ..sprite = await gameRef.loadSprite('GOTA3.png')
      ..size = Vector2(gameSize[0]*0.071, gameSize[1]*0.0401)
      ..position = Vector2(gameSize[0]*0.154, gameSize[1]*0.825);

    // add(GotaLevel3);

    GotaLevel4
      ..sprite = await gameRef.loadSprite('GOTA4.png')
      ..size = Vector2(gameSize[0]*0.071, gameSize[1]*0.0351)
      ..position = Vector2(gameSize[0]*0.154, gameSize[1]*0.865);

    // add(GotaLevel4);
  }

  bool gota_updateScore(int gota_newScore) {
      this.gota_score += gota_newScore;
      changeSpriteLevel(1);
      return true;
  }
  int getGotaScore(){
    return this.g;
  }
  bool changeSpriteLevel(int level) {
    this.g += level;
    if(g == 1){
      GotaLevel4.removeFromParent();
    }
    else if(g == 2){
      GotaLevel3.removeFromParent();
    }
    else if(g == 3){
      GotaLevel2.removeFromParent();
    }
    else if(g == 4){
      GotaLevel1.removeFromParent();
    }
    return true;
  }

  bool recycleLevel(int add_level){
    this.gota_score -= 1;
    this.g -= add_level;
    if(g == 0){
      add(GotaLevel4);
      }
      else if(g == 1){
        add(GotaLevel3);
      }
      else if(g == 2){
        add(GotaLevel2);
      }
      else if(g == 3){
        add(GotaLevel1);
    }
    return true;
  }
}