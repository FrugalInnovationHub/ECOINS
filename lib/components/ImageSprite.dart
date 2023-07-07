
import 'package:flame/effects.dart';
import 'package:flame/components.dart';

class ImageSprite extends SpriteComponent with HasGameRef {
  late final asset;
  final OpacityEffect h_opacity_effect = OpacityEffect.to(0.25, EffectController(duration: 1, startDelay: 0));
  ImageSprite({super.position, super.size, super.angle ,this.asset});


  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(this.asset);
  }

  void addOpacity(){
    add(h_opacity_effect);
  }
}