import 'dart:math';

import 'package:ecoins/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'globals.dart';

enum PowerUp_Type_Comp implements Comparable<PowerUp_Type_Comp>{
  Gota_Agua(src: 'Gota_agua.png'),
  Sol(src: 'Sol.png');


  const PowerUp_Type_Comp({
    required this.src
  });

  final src;

  @override
  int compareTo(PowerUp_Type_Comp other) {
    if (src == other.src) {
      return 0;
    } else {
      return -1;
    }
  }
}

class PowerUpComponent extends SpriteComponent with HasGameRef, ParentIsA<EcoinsGame>,Tappable,CollisionCallbacks {
  final double _spriteHeight = 150.0;
  final double _spriteWidth = 800.0;
  final Random _random = Random();
  late RemoveEffect h_remove_effect;
  late OpacityEffect h_opacity_effect;
  PowerUp_Type_Comp type;
  double delay;
  double y_loc;
  bool is_colliding = false;


  PowerUpComponent(PowerUp_Type_Comp type, double delay, double y_loc) :
        this.type = type, this.delay = delay, this.y_loc = y_loc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(type.src);
    height = _spriteHeight;
    width = _spriteWidth;
    anchor = Anchor.center;
    position = gameRef.size / 2;

    position = _createRandomPosition();
    add(RectangleHitbox());

    h_remove_effect = RemoveEffect(delay: 5);

    update_move();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true
    if(is_colliding){
      FlameAudio.play(Globals.itemGrabSound);
      removeFromParent();
    }
    return false;
  }

  update_move() {
  add(h_remove_effect);
  Future.delayed(Duration(seconds: 10), () {
    gameRef.add(PowerUpComponent(type, delay, y_loc));
  });
  }
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    is_colliding = true;
  }
  Vector2 _createRandomPosition() {
    final double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    final double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }
}


