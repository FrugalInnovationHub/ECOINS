
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

class ImageSprite extends SpriteComponent with HasGameRef {
  late final asset;
  ImageSprite({super.position, super.size, super.angle ,this.asset});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(this.asset);
  }
}