import 'package:ecoins/components/ImageSprite.dart';
import 'package:ecoins/components/playButton.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomeScreen extends FlameGame with HasTappables {

  late BuildContext context;
  // ImageSprite ecoins = ImageSprite();
  // ImageSprite cangrejo2 = ImageSprite();
  // ImageSprite cangrejo1 = ImageSprite();
  // ImageSprite cangrejo3 = ImageSprite();
  // ImageSprite dolphin1 = ImageSprite();
  // ImageSprite dolphin2 = ImageSprite();
  // ImageSprite girl = ImageSprite();
  // ImageSprite whale = ImageSprite();
  // ImageSprite turtle = ImageSprite();
  // ImageSprite pelican = ImageSprite();
  ImageSprite homeScreen1 = ImageSprite();
  late PlayButton button;
  // late PolygonComponent triangle;

  Paint blue = Paint()
    ..color = const Color(0xFF3A9BDC);
  Paint green = Paint()
    ..color = const Color(0xFF00FF00);

  HomeScreen({ required this.context});

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  void onClick() {
    Navigator.pushReplacementNamed(this.context, '/video');
  //   ecoins.addOpacity();
  //   pelican.addOpacity();
  //   whale.addOpacity();
  //   dolphin1.addOpacity();
  //   dolphin2.addOpacity();
  //   triangle.add(h_opacity_effect);
  //   data = ImageSprite(asset: 'data.png', position: Vector2(size[0] * 0.25, size[1] * 0.275), size: Vector2(size[0] * 0.5, size[1] * 0.4));
  //   Future.delayed(Duration(seconds: 1) ,() => add(data));
  //   overlays.add("EnterData");

  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var y = (size[0] / 16)*9;
    camera.viewport = FixedResolutionViewport(Vector2(size[0], y));
    // ecoins = ImageSprite(asset: 'ecoins_logo.png',
    //     position: Vector2(size[0] * 0.31, size[1] * 0.34),
    //     size: Vector2(size[0] * 0.37, size[1] * 0.27));
    // cangrejo2 = ImageSprite(asset: 'cangrejo.png',
    //     position: Vector2(size[0]*0.18, size[1] * 0.75),
    //     size: Vector2(size[0] * 0.1, size[1] * 0.17));
    // cangrejo1 = ImageSprite(asset: 'cangrejo.png',
    //     position: Vector2(size[0] * 0.045, size[1] * 0.75),
    //     size: Vector2(size[0] * 0.08, size[1] * 0.13));
    // cangrejo3 = ImageSprite(asset: 'cangrejo.png',
    //     position: Vector2(size[0] * 0.88, size[1] * 0.82),
    //     size: Vector2(size[0] * 0.09, size[1] * 0.15));
    // dolphin1 = ImageSprite(asset: 'DOLPHIN.png',
    //     position: Vector2(size[0] * 0.08, size[1] * 0.22),
    //     size: Vector2(size[0] * 0.06, size[1] * 0.32),
    //     angle: -2);
    // dolphin2 = ImageSprite(asset: 'DOLPHIN.png',
    //     position: Vector2(size[0] * 0.30, size[1] * 0.37),
    //     size: Vector2(size[0] * 0.05, size[1] * 0.25),
    //     angle: -2);
    // girl = ImageSprite(asset: 'GIRL.png',
    //     position: Vector2(size[0] * 0.75, size[1] * 0.11),
    //     size: Vector2(size[0] * 0.2, size[1] * 0.87));
    // whale = ImageSprite(asset: 'WHALE.png',
    //     position: Vector2(-(size[0] * 0.08), size[1] * 0.98),
    //     size: Vector2(size[0] * 0.18, size[1] ),
    //     angle: -2.25);
    // turtle = ImageSprite(asset: 'Turtle.png',
    //     position: Vector2(size[0] * 0.64, size[1] * 0.80),
    //     size: Vector2(size[0] * 0.2, size[1] * 0.18));
    // pelican = ImageSprite(asset: 'Pelican.png',
    //     position: Vector2(size[0] * 0.50, size[1] * 0.26),
    //     size: Vector2(size[0] * 0.08, size[1] * 0.20));

    homeScreen1 = ImageSprite(asset: 'HomeScreen_1.jpeg',
      position: Vector2(0,0),
      size: Vector2(size[0], size[1])
    );

    button = PlayButton(radius: size[0] * 0.037,
        position: Vector2(size[0] * 0.54, size[1] * 0.49),
        // paint: green,
        context: this.context,
        onClick: onClick
    );

    await add(button);
    await add(homeScreen1);

    // button = PlayButton(radius: size[0] * 0.037,
    //     position: Vector2(size[0] * 0.55, size[1] * 0.55),
    //     paint: blue,
    //     context: this.context);
    // triangle = PolygonComponent([
    //   Vector2(0, 0),
    //   Vector2(size[0] * 0.037, size[1] * 0.035),
    //   Vector2(0, size[1] * 0.07)
    // ], position: Vector2(size[0] * 0.575, size[1] * 0.58),
    //     paint: green,
    //     size: Vector2(size[0] * 0.12, size[1] * 0.22));


    // await add(ecoins);
    // await add(cangrejo1);
    // await add(cangrejo2);
    // await add(cangrejo3);
    // await add(dolphin1);
    // await add(dolphin2);
    // await add(turtle);
    // await add(girl);
    // await add(whale);
    //
    // await add(pelican);

    // await add(triangle);
  }
}