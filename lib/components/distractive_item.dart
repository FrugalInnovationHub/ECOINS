
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

enum Distractive_Type implements Comparable<Distractive_Type> {
  Cangrejo(src: 'cangrejo.png', size: [30, 40], angle: 0),
  Whale(src: 'WHALE.png', size: [40, 80], angle: -2),
  Turtle(src: 'Turtle.png', size: [40, 45], angle: 0),
  Pelican(src: 'Pelican.png', size: [30, 45], angle: 0),
  Dolphin(src: 'DOLPHIN.png', size: [35, 80], angle: -1.75);


  const Distractive_Type({
    required this.src,
    required this.size,
    required this.angle
  });

  final src;
  final size;
  final angle;

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
  late final ratio;
  bool is_moving = true;
  Distractive_Type type;
  double delay;
  double y_loc;

  DistractiveItem(Distractive_Type type, double delay, double y_loc) :
        this.type = type, this.delay = delay, this.y_loc = y_loc;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    ratio = double.parse((gameRef.size[0] / gameRef.size[1]).toStringAsFixed(1));
    y_loc = y_loc - ratio * type.size[1];
    sprite = await gameRef.loadSprite(type.src);
    position = Vector2(-(ratio * 60), y_loc);
    size = Vector2(ratio * type.size[0], ratio * type.size[1]);
    angle = type.angle;
    if(type == Distractive_Type.Whale || type == Distractive_Type.Dolphin) {
      y_loc = y_loc + 1.25 * ratio * type.size[1];
      position.y = y_loc;
    }

    add(RectangleHitbox());
    h_move_effect = MoveEffect.to(
      Vector2(gameRef.size.length, y_loc),
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
    } else {
      h_move_effect.removeFromParent();
    }
  }
}
