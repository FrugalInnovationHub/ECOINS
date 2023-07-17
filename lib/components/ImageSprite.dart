import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class ImageSprite extends SpriteComponent with HasGameRef {
  late final asset;
  final OpacityEffect h_opacity_effect = OpacityEffect.to(0.25, EffectController(duration: 1, startDelay: 0));
  ImageSprite({super.position, super.size, super.angle ,this.asset});


  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(this.asset);
  }

  void addOpacity(){
    add(h_opacity_effect);
  }

  void addText(score) async {
    final _style = TextStyle(
        color: BasicPalette.white.color,
        fontSize: gameRef.size[0]*0.05,
        fontWeight: FontWeight.bold
    );
    final _paint = TextPaint(style: _style);

    var imageText = ImageText(
        textRenderer: _paint,
        position: Vector2(this.size[0]*0.5, this.size[1]*0.55)
    );
    imageText.score = score;
    await add(imageText);
  }
}

class ImageText extends TextComponent with HasGameRef {
  late int score;

  ImageText({super.textRenderer, super.position}) : score = 0;

  @override
  void render(Canvas canvas) {
    textRenderer.render(canvas, '$score', Vector2.zero(), anchor: Anchor.center);
  }
}