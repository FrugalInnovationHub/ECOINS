
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

enum Distractive_Type implements Comparable<Distractive_Type> {
  Cangrejo(src: 'cangrejo.png', size: [0.035, 0.09], angle: 0, add_y: 0.10, priority: 2),
  Whale(src: 'WHALE.png', size: [0.045, 0.17], angle: -2, add_y: 1.35, priority: 1),
  Turtle(src: 'Turtle.png', size: [0.055, 0.09], angle: 0, add_y: 0.30, priority: 2),
  Pelican(src: 'Pelican.png', size: [0.035, 0.095], angle: 0, add_y: 0.10, priority: 2),
  Dolphin(src: 'DOLPHIN.png', size: [0.040, 0.17], angle: -1.75, add_y: 1.15, priority: 1);


  const Distractive_Type({
    required this.src,
    required this.size,
    required this.angle,
    required this.add_y,
    required this.priority
  });

  final src;
  final size;
  final angle;
  final add_y;
  final priority;

  @override
  int compareTo(Distractive_Type other) {
    if (src == other.src) {
      return 0;
    } else {
      return -1;
    }
  }
}

class DistractiveItem extends SpriteComponent with HasGameRef, Tappable{
  late MoveEffect h_move_effect;
  // late final h_opacity_blink_effect;
  late final h_remove_effect;
  bool is_moving = true;
  Distractive_Type type;
  double delay;
  double y_loc;
  late var gameSize;

  DistractiveItem(Distractive_Type type, double delay, double y_loc) :
        this.type = type, this.delay = delay, this.y_loc = y_loc;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameSize = gameRef.size;
    var y = y_loc - (1 - type.add_y)*gameSize[1] * type.size[1];
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-(gameSize[0] * 0.1), y);
    size = Vector2(gameSize[0] * type.size[0], gameSize[1] * type.size[1]);
    angle = type.angle;
    priority = type.priority;

    add(RectangleHitbox());
    // h_opacity_blink_effect = OpacityEffect.to(2, EffectController(duration: 3, repeatCount: 3, startDelay: 40 + delay));
    h_remove_effect = RemoveEffect(delay: 35 + delay);
    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, y),
      EffectController(
          startDelay: delay,
          duration: 20,
          infinite: true,
          alternate: true
      ),
    );
    update_move();
  }

  update_move() {
    if(is_moving == true) {
      add(h_move_effect);
      // add(h_opacity_blink_effect);
      add(h_remove_effect);
    } else {
      h_move_effect.removeFromParent();
    }
  }
}
