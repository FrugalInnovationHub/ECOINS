import 'package:flame/components.dart';

class BasuresosLock extends SpriteComponent with HasGameRef{
  late var type;

  BasuresosLock({super.position, super.size, this.type});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    sprite = await gameRef.loadSprite('Lock.png');

  }
}