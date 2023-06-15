
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

class TutorialAnimation extends PositionComponent with HasGameRef{
  late final text_url;
  late final audio_url;
  late final align;
  late final is_girl_image;
  TutorialAnimation({super.position, super.size, required this.text_url});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpriteComponent textSprite;
    SpriteComponent girlSprite = SpriteComponent(sprite: await gameRef.loadSprite("NINA_POP_UP.png"), position: Vector2(0,350), size: Vector2(size[0]*0.4, size[1]));
    var sprite = await gameRef.loadSprite(this.text_url);
    textSprite = SpriteComponent(sprite: sprite, position: Vector2(size[0]*0.35, size[1]), size: Vector2(size[0]*0.8, size[1]));
    add(girlSprite);
    add(textSprite);
  }
}