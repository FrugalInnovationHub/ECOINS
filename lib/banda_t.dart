import 'package:flame/components.dart';
import 'package:flame_svg/flame_svg.dart';

class Banda_T extends SvgComponent with HasGameRef {

  Banda_T({super.position, super.size});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    svg = await Svg.load('images/svg/banda_transportadora_1.svg');
  }
}
