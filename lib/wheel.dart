import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';

class Wheel extends PositionComponent with HasGameRef {

  Wheel({super.position, super.size});


  @override
  Future<void> onLoad() async {
    super.onLoad();

    // sprite = await gameRef.loadSprite('Tuerca_transparencia.gif');
    // sprite = await gameRef.loadSprite('croppedWheel.gif');
    final imageInstance = await Flame.images.load('wheelSprite.png');
    final spriteSheet = SpriteSheet(image: imageInstance, srcSize: Vector2(248.5, 245));
    final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, loop: true);
    final animationComponent = SpriteAnimationComponent(
      animation: animation,
      position: this.position,
      size: this.size,
    );
    add(animationComponent);
  }

}