import 'package:ecoins/components/ImageSprite.dart';
import 'package:ecoins/components/playButton.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomeScreen extends FlameGame with HasTappables {

  late BuildContext context;
  ImageSprite ecoins = ImageSprite();
  ImageSprite cangrejo2 = ImageSprite();
  ImageSprite cangrejo1 = ImageSprite();
  ImageSprite cangrejo3 = ImageSprite();
  ImageSprite dolphin1 = ImageSprite();
  ImageSprite dolphin2 = ImageSprite();
  ImageSprite girl = ImageSprite();
  ImageSprite whale = ImageSprite();
  ImageSprite turtle = ImageSprite();
  ImageSprite pelican = ImageSprite();
  late PlayButton button;
  late PolygonComponent triangle;

  Paint blue = Paint()
    ..color = const Color(0xFF3A9BDC);
  Paint green = Paint()
    ..color = const Color(0xFF00FF00);

  HomeScreen({ required this.context});

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var ratio = MediaQuery
        .of(context)
        .size
        .width / MediaQuery
        .of(context)
        .size
        .height;
    // print(ratio);

    ecoins = ImageSprite(asset: 'ecoins_logo.png',
        position: Vector2(size[0] * 0.31, size[1] * 0.34),
        size: Vector2(size[0] * 0.37, size[1] * 0.27));
    cangrejo2 = ImageSprite(asset: 'cangrejo.png',
        position: Vector2(size[0]*0.18, size[1] * 0.75),
        size: Vector2(size[0] * 0.1, size[1] * 0.17));
    cangrejo1 = ImageSprite(asset: 'cangrejo.png',
        position: Vector2(size[0] * 0.045, size[1] * 0.75),
        size: Vector2(size[0] * 0.08, size[1] * 0.13));
    cangrejo3 = ImageSprite(asset: 'cangrejo.png',
        position: Vector2(size[0] * 0.88, size[1] * 0.82),
        size: Vector2(size[0] * 0.09, size[1] * 0.15));
    dolphin1 = ImageSprite(asset: 'DOLPHIN.png',
        position: Vector2(size[0] * 0.08, size[1] * 0.22),
        size: Vector2(size[0] * 0.06, size[1] * 0.32),
        angle: -2);
    dolphin2 = ImageSprite(asset: 'DOLPHIN.png',
        position: Vector2(size[0] * 0.30, size[1] * 0.37),
        size: Vector2(size[0] * 0.05, size[1] * 0.25),
        angle: -2);
    girl = ImageSprite(asset: 'GIRL.png',
        position: Vector2(size[0] * 0.75, size[1] * 0.11),
        size: Vector2(size[0] * 0.2, size[1] * 0.87));
    whale = ImageSprite(asset: 'WHALE.png',
        position: Vector2(-(size[0] * 0.08), size[1] * 0.98),
        size: Vector2(size[0] * 0.18, size[1] ),
        angle: -2.25);
    turtle = ImageSprite(asset: 'Turtle.png',
        position: Vector2(size[0] * 0.64, size[1] * 0.80),
        size: Vector2(size[0] * 0.2, size[1] * 0.18));
    pelican = ImageSprite(asset: 'Pelican.png',
        position: Vector2(size[0] * 0.50, size[1] * 0.26),
        size: Vector2(size[0] * 0.08, size[1] * 0.20));


    button = PlayButton(radius: size[0] * 0.037,
        position: Vector2(size[0] * 0.55, size[1] * 0.55),
        paint: blue,
        context: this.context);
    triangle = PolygonComponent([
      Vector2(0, 0),
      Vector2(size[0] * 0.037, size[1] * 0.035),
      Vector2(0, size[1] * 0.07)
    ], position: Vector2(size[0] * 0.575, size[1] * 0.58),
        paint: green,
        size: Vector2(ratio * 10, ratio * 10));

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
    await add(button);
    await add(triangle);
  }

  // void resizeComponents(var ratio, Vector2 size){
  //   ecoins.position = Vector2(size[0]*0.31, size[1] * 0.34);
  //   ecoins.size = Vector2(size[0] * 0.37, size[1] * 0.27);
  //   cangrejo2.position =  Vector2(size[0]*0.18, size[1] * 0.75);
  //   cangrejo2.size = Vector2(size[0] * 0.1, size[1] * 0.17);
  //   cangrejo1.position =  Vector2(ratio * 37.5, ratio * 360);
  //   cangrejo1.size = Vector2(ratio * 67.5, ratio * 60);
  //   cangrejo3 = ImageSprite(asset: 'cangrejo.png',
  //       position: Vector2(ratio * 720, ratio * 380),
  //       size: Vector2(ratio * 75, ratio * 70));
  //   dolphin1 = ImageSprite(asset: 'DOLPHIN.png',
  //       position: Vector2(ratio * 70, ratio * 100),
  //       size: Vector2(ratio * 50, ratio * 150),
  //       angle: -2);
  //   dolphin2 = ImageSprite(asset: 'DOLPHIN.png',
  //       position: Vector2(ratio * 250, ratio * 175),
  //       size: Vector2(ratio * 40, ratio * 125),
  //       angle: -2);
  //   girl = ImageSprite(asset: 'GIRL.png',
  //       position: Vector2(ratio * 615, ratio * 50),
  //       size: Vector2(ratio * 165, ratio * 410));
  //   whale = ImageSprite(asset: 'WHALE.png',
  //       position: Vector2(-(ratio * 75), ratio * 475),
  //       size: Vector2(ratio * 150, ratio * 500),
  //       angle: -2.25);
  //   turtle = ImageSprite(asset: 'Turtle.png',
  //       position: Vector2(ratio * 525, ratio * 380),
  //       size: Vector2(ratio * 160, ratio * 80));
  //   pelican = ImageSprite(asset: 'Pelican.png',
  //       position: Vector2(ratio * 405, ratio * 125),
  //       size: Vector2(ratio * 80, ratio * 89));
  //
  //
  //   button = PlayButton(radius: ratio * 30,
  //       position: Vector2(ratio * 450, ratio * 260),
  //       paint: blue,
  //       context: this.context);
  //   triangle = PolygonComponent([
  //     Vector2(0, 0),
  //     Vector2(ratio * 30, ratio * 15),
  //     Vector2(0, ratio * 30)
  //   ], position: Vector2(ratio * 470, ratio * 275),
  //       paint: green,
  //       size: Vector2(ratio * 10, ratio * 10));
  // }

  // @override
  // void onGameResize(Vector2 size) {
  //   // TODO: implement onGameResize
  //   super.onGameResize(size);
  //   var ratio = size[0]/size[1];
  //   resizeComponents(ratio, size);
  // }
}