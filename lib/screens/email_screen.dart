import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/src/text/text_renderer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/ImageSprite.dart';
import '../palette.dart';



class Email_Screen extends FlameGame with HasTappables{
  ImageSprite emailScreen1 = ImageSprite();
  ImageSprite emailScreen2 = ImageSprite();
  ImageSprite box = ImageSprite();
  late OpacityEffect h_opacity_effect;
  late OpacityEffect h_opacity_effect_new;
  late BuildContext context;

  Email_Screen({ required this.context});
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var y = (size[0] / 16)*9;
    camera.viewport = FixedResolutionViewport(Vector2(size[0], y));
    emailScreen1 = ImageSprite(asset: 'END_SCREEN_3.jpeg',
        position: Vector2(0,0),
        size: Vector2(size[0], size[1]));
    emailScreen2 = ImageSprite(asset: 'END_SCREEN_2.jpeg',
        position: Vector2(0,0),
        size: Vector2(size[0], size[1]));
    box = ImageSprite(asset: 'box.png',
        position: Vector2(size[0] * 0.47 ,size[1] * 0.24),
        size: Vector2(size[0] * 0.51, size[1] * 0.4));
    box.opacity = 0;
    h_opacity_effect = OpacityEffect.to(0, EffectController(duration: 1, startDelay: 3));
    h_opacity_effect_new = OpacityEffect.to(1, EffectController(duration: 1, startDelay: 3));

    // emailScreen2.add(h_opacity_effect_new);


    await add(emailScreen2);
    await add(emailScreen1);
    emailScreen1.add(h_opacity_effect);
    await add(box);
    box.add(h_opacity_effect_new);
    Future.delayed(const Duration(milliseconds: 3500), () { overlays.add("textField"); });



  }
}