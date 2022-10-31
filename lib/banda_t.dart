import 'dart:js';

import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/cupertino.dart';

class Banda_T extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('banda_transportadora.png');
    //double width = MediaQuery.of(context).size.width;
    size = Vector2(width, 20);
  }
}
