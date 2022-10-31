import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';

import 'botella_plastico.dart';

class Banda_T_Hole extends SpriteComponent with HasGameRef{
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('banda_transportadora_hole.png');
    size = Vector2(100, 20);

    add(RectangleHitbox());
  }
}
