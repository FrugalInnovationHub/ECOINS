import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

class Banda_T extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // final svg = await Svg.load('images/banda_transportadora.svg');
    // final sprite = SvgComponent(
    //   svg: svg,
    //   position: Vector2.all(100),
    //   size: Vector2.all(100),
    // );
  }
}
