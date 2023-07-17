import 'package:flame/components.dart';

class Cocina extends SpriteComponent with HasGameRef {

  Cocina({ super.size });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('Cocina_blur.png');
  }
}
