import 'dart:ui';

import 'package:flame/game.dart';
import 'cocina.dart';

class EcoinsGame extends FlameGame{
  Cocina _cocina = Cocina();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_cocina);
    // await add(_dinoPlayer);
    // _dinoPlayer.position = _dinoWorld.size / 1.5;
    // camera.followComponent(_dinoPlayer,
    //     worldBounds: Rect.fromLTRB(0, 0, _dinoWorld.size.x, _dinoWorld.size.y));
  }
}