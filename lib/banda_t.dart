import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flame/flame.dart';

import 'dart:ui';

class Banda_T extends SpriteComponent with HasGameRef {

  Banda_T({super.position, super.size});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // sprite = await gameRef.loadSprite('uno_banda_transportadora.png');
    sprite = await gameRef.loadSprite('conveyor_belt.png');
  }

}
