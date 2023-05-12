import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';

import 'trash_items.dart';

class Banda_T_Hole extends PositionComponent with HasGameRef{

  late var hole_no;
  Banda_T_Hole() {
    this.size = Vector2(100, 20);
    this.hole_no = 0;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // sprite = await gameRef.loadSprite('banda_transportadora_hole.png');
    add(RectangleHitbox());
  }
}
