import 'package:flame/components.dart';

class Cocina extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('cocina.png');
    size = gameRef.size;
    // size = Vector2.all(1024.0);
  }
}
