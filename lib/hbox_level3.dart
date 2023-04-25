import 'dart:html';

import 'package:ecoins/palette.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class hbox_level3 extends RectangleComponent with HasGameRef{
  hbox_level3({required size, required position})
    : super(size: size, position: position){
    debugMode = false;
  }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    this.paint = Palette.transp.paint();
    add(RectangleHitbox());
  }
}