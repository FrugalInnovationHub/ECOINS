import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';

import 'palette.dart';

enum Powerup_Type {
  Sol,
  Gota_Agua
}

class Powerup_HBox extends CircleComponent {
  var type;
  Powerup_HBox(type, {
    super.position,
    super.angle,
    super.anchor,
    super.priority,
  }) : type = type;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    this.paint = Palette.transp.paint();
    var h_box = CircleHitbox();
    add(h_box);
  }
}