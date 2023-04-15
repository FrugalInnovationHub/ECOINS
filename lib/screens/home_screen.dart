
import 'dart:ui';

import 'package:ecoins/components/ImageSprite.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class HomeScreen extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var ratio = this.size[0]/this.size[1];
    final ImageSprite ecoins = ImageSprite(asset: 'ecoins_logo.png', position: Vector2(ratio*260,ratio*160), size: Vector2(ratio*300,ratio*125));
    final ImageSprite cangrejo2 = ImageSprite(asset: 'cangrejo.png', position: Vector2(ratio*150,ratio*350), size: Vector2(ratio*90,ratio*84));
    final ImageSprite cangrejo1 = ImageSprite(asset: 'cangrejo.png', position: Vector2(ratio*37.5,ratio*360), size: Vector2(ratio*67.5,ratio*60));
    final ImageSprite cangrejo3 = ImageSprite(asset: 'cangrejo.png', position: Vector2(ratio*720,ratio*380), size: Vector2(ratio*75,ratio*70));
    final ImageSprite dolphin1 = ImageSprite(asset: 'DOLPHIN.png', position: Vector2(ratio*170,ratio*50), size: Vector2(ratio*50,ratio*150), angle: -2);
    final ImageSprite dolphin2 = ImageSprite(asset: 'DOLPHIN.png', position: Vector2(ratio*350,ratio*125), size: Vector2(ratio*40,ratio*125), angle: -2);
    final ImageSprite girl = ImageSprite(asset: 'GIRL.png', position: Vector2(ratio*615,ratio*50), size: Vector2(ratio*165,ratio*410));
    final ImageSprite whale = ImageSprite(asset: 'WHALE.png', position: Vector2(ratio*300,ratio*175), size: Vector2(ratio*150,ratio*500), angle: -2.25);
    final ImageSprite turtle = ImageSprite(asset: 'Turtle.png', position: Vector2(ratio*685,ratio*380), size: Vector2(ratio*160,ratio*80));
    final ImageSprite pelican = ImageSprite(asset: 'Pelican.png', position: Vector2(ratio*405,ratio*125), size: Vector2(this.size[0]*0.1,this.size[1]*0.19));

    turtle.flipHorizontally();
    dolphin1.flipVertically();
    dolphin2.flipVertically();
    whale.flipVertically();
    await add(ecoins);
    await add(cangrejo1);
    await add(cangrejo2);
    await add(cangrejo3);
    await add(dolphin1);
    await add(dolphin2);
    await add(turtle);
    await add(girl);
    await add(whale);

    await add(pelican);

  }
}