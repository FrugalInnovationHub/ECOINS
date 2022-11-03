import 'dart:ui';
import 'dart:io';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cocina.dart';
import 'banda_t.dart';
import 'trash_items.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'pause_btn.dart';

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection{
  Cocina _cocina = Cocina();
  Banda_T _banda_t = Banda_T();
  Botella_Plastico _bp = Botella_Plastico();
  Basureros _basureros = Basureros();
  Pause_Btn _pause_btn = Pause_Btn();

  var hole_pos = [
    Vector2(850, 100),
    Vector2(350, 200),
    Vector2(700, 300)
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // debugMode = true;
    await add(_cocina);
    await add(_pause_btn);


    var _banda_t_holes = [];

    for(Vector2 pos in hole_pos) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos;
      _banda_t_holes.add(_banda_t_hole);
    }

    for (Banda_T_Hole _hole in _banda_t_holes) {
      await add(_hole);
    }

    await add(_basureros);
    await add(_bp);
  }
}