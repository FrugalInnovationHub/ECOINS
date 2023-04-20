import 'dart:math';
import 'package:ecoins/basureros.dart';
import 'package:ecoins/basureros_hbox.dart';
import 'package:ecoins/game.dart';
import 'package:ecoins/sol_scored.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';

import 'globals.dart';
import 'gota_scored.dart';

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

  final Random _random = Random();
  bool sol_scored = false;
  late RemoveEffect h_remove_effect;
  late ScaleEffect h_scale_effect;
  late var name;
  late OpacityEffect h_opacity_effect;
  late OpacityEffect h_opacity_blick_effect;
  PowerUp_Type_Comp type;
  double delay;
  double y_loc;
  bool is_colliding_sol = false;
  late EffectController effectController;

  

  PowerUpComponent(PowerUp_Type_Comp type, double delay, double y_loc) :
        this.type = type, this.delay = delay, this.y_loc = y_loc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var gameSize = gameRef.size;
    var ratio = gameSize[0]/gameSize[1];
    final double _spriteHeight = ratio*30;
    final double _spriteWidth = ratio*27;
    sprite = await gameRef.loadSprite(type.src);


    height = _spriteHeight;
    width = _spriteWidth;
    anchor = Anchor.center;
    position = gameRef.size / 2;


    position = _createRandomPosition();


    h_opacity_blick_effect = OpacityEffect.to(2, EffectController(duration: 1, repeatCount: 3, startDelay: 5));
    h_scale_effect = ScaleEffect.by(Vector2.all(1.5), EffectController(duration: 0.7));
    h_remove_effect = RemoveEffect(delay: 8);
    // h_opacity_effect = OpacityEffect.to(0, EffectController(duration: 0.75, startDelay: 5));

    update_move();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // info.handled = true
    final allPositionComponents = parent.children.query<PositionComponent>();
    Sol_Score_Disp ?sol_score;
    for (PositionComponent sol in allPositionComponents) {
      if (sol is Sol_Score_Disp) {
        sol_score = sol;
      }
    }
    Gota_Score_Disp ?gota_score;
    for (PositionComponent gota in allPositionComponents) {
      if (gota is Gota_Score_Disp) {
        gota_score = gota;
      }
    }
      // Check which gem was clicked on
      switch (type) {
        case PowerUp_Type_Comp.Gota_Agua:
          gota_score?.gota_updateScore(10);
          break;
        // Handle GotaAgua gem click
          break;
        case PowerUp_Type_Comp.Sol:
        // Handle Sol gem click
          sol_score?.sol_updateScore(10);
          break;
      }
      FlameAudio.play(Globals.itemGrabSound);
      removeFromParent();

      return false;

  }

  update_move() {
    add(h_scale_effect);
    add(h_opacity_blick_effect);
    add(h_remove_effect);
    // add(h_opacity_effect);
  Future.delayed(Duration(seconds: 10), () {
    gameRef.add(PowerUpComponent(type, delay, y_loc));
  });
  }
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {

      is_colliding_sol = true;

      }
  Vector2 _createRandomPosition() {
    final double x = _random.nextInt(gameRef.size.x.toInt()).toDouble();
    final double y = _random.nextInt(gameRef.size.y.toInt()).toDouble();

    return Vector2(x, y);
  }
  @override
  void onCollisionEnd(PositionComponent other) {

  }
}


