import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_svg/flame_svg.dart';

import 'trash_items.dart';

class Basureros extends SpriteComponent with HasGameRef{
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('basureros.png');
    position = Vector2(700, 400);
    size = Vector2(200, 100);

    add(RectangleHitbox(
      size: Vector2(50,100)
    ));
  }
}
