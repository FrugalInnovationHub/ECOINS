import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';

class Wheel extends SpriteComponent with HasGameRef {

  Wheel({super.position, super.size});


  @override
  Future<void> onLoad() async {
    super.onLoad();

    // sprite = await gameRef.loadSprite('Tuerca_transparencia.gif');
    sprite = await gameRef.loadSprite('croppedWheel.gif');
    // final imageInstance = await Flame.images.load('wheelSprite.png');
    // print(imageInstance);
    // // final spriteSheet = SpriteSheet(image: imageInstance, srcSize: Vector2.all(24.0));
    // final spriteSheet = SpriteSheet.fromColumnsAndRows(
    //   image: imageInstance,
    //   columns: 5,
    //   rows: 50,
    // );
    // print(spriteSheet);
    // final animation = spriteSheet.createAnimation(row: 0, stepTime: 0.1);
    // final animationComponent = SpriteAnimationComponent(
    //   animation: animation,
    //   position: this.position,
    //   size: this.size,
    // );

    // final data = SpriteAnimationData.sequenced(
    //   textureSize: Vector2(490,497),
    //   amount: 250,
    //   stepTime: 0.1,
    // );
    // final animationComponent = SpriteAnimationComponent.fromFrameData(
    //     await Flame.images.load('wheelSprite.png'),
    //   data
    // );
    // add(animationComponent);
  }

}