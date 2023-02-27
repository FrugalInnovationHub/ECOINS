import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';

import 'trash_items.dart';

class Banda_T_Hole extends SpriteComponent with HasGameRef{

  Banda_T_Hole() {
    this.size = Vector2(100, 20);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('banda_transportadora_hole.png');
    add(RectangleHitbox());
  }
}
