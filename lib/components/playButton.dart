

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class PlayButton extends CircleComponent with Tappable, HasGameRef {
  late BuildContext context;
  late Function onClick;

  PlayButton({ super.position, super.paint, super.radius, required this.context, required this.onClick  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final buttonHitBox = CircleHitbox();
    add(buttonHitBox);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    onClick();
    return false;
  }
}