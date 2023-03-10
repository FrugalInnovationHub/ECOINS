import 'package:flame/components.dart';

class Cocina extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('Cocina.png');
    size = gameRef.size;
  }
}
