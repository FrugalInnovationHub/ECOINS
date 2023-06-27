import 'package:ecoins/components/ImageSprite.dart';
import 'package:ecoins/components/playButton.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ecoins/components/TutorialAnimation.dart';
import 'package:flame_audio/flame_audio.dart';

class HomeScreen extends FlameGame with HasTappables {

  late BuildContext context;
  ImageSprite homeScreen1 = ImageSprite();
  ImageSprite homeScreen2 = ImageSprite();
  late PlayButton button;
  late TutorialAnimation animation;

  Paint blue = Paint()
    ..color = const Color(0xFF3A9BDC);
  Paint green = Paint()
    ..color = const Color(0xFF00FF00);

  HomeScreen({ required this.context});

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  void onClick() async {
    homeScreen2 = ImageSprite(asset: 'HomeScreen_2.jpeg',
        position: Vector2(0,0),
        size: Vector2(size[0], size[1])
    );
    ImageSprite data = ImageSprite(asset: 'data.png', position: Vector2(size[0] * 0.25, size[1] * 0.275), size: Vector2(size[0] * 0.5, size[1] * 0.4));
    ImageSprite textSprite = ImageSprite(asset: "INTRO_1.png",position: Vector2(size[0]*0.3, size[1]*0.01), size: Vector2(size[0]*0.5, size[1]*0.2));
    add(textSprite);
    var audio = await FlameAudio.play("INTRO_1.mp3");
    audio.onPlayerStateChanged.listen((event) {
      textSprite.removeFromParent();

      Future.delayed(Duration(milliseconds: 30) ,() {
        add(homeScreen2);
        add(data);
        homeScreen1.removeFromParent();
      });
      overlays.add("EnterData");
    });
    // add(homeScreen2);
    // add(data);
    // homeScreen1.removeFromParent();
    // overlays.add("EnterData");
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var y = (size[0] / 16)*9;
    camera.viewport = FixedResolutionViewport(Vector2(size[0], y));

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
  }
}