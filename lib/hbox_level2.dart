// import 'dart:html';

import 'package:ecoins/palette.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class hbox_level2 extends RectangleComponent with HasGameRef{
  hbox_level2({required size, required position})
    : super(size: size, position: position){
    debugMode = true;
  }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    this.paint = Palette.transp.paint();
    add(RectangleHitbox(isSolid:false));
  }
}