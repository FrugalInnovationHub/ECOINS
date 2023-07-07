import 'package:flame/components.dart';

class Banda_T extends SpriteComponent with HasGameRef {
  late final asset;
  late final hole_no;
  Banda_T({super.position, super.size, super.angle, required this.asset, this.hole_no = 0});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(asset);
  }

}
