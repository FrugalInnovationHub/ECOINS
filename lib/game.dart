import 'dart:ui';
import 'dart:io';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'cocina.dart';
import 'banda_t.dart';
import 'trash_items.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'pause_btn.dart';
import 'score_disp.dart';

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection{
  final Cocina _cocina = Cocina();
  final Basureros _basureros = Basureros();
  final Pause_Btn _pause_btn = Pause_Btn();
  final Score_Disp _score_disp = Score_Disp();
  final _random = new Random();
  final double _trash_start_y = 50;

  var hole_pos = [
    Vector2(850, 100),
    Vector2(350, 200),
    Vector2(700, 300),
    Vector2(800, 300)
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<PositionComponent>();
    // debugMode = true;
    await add(_cocina);
    await add(_pause_btn);
    await add(_score_disp);

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

    var _trash_items = [];
    var indexes = Trash_Type.values.mapIndexed((index, element) => index).toList();

    // Generate 3 levels of trash items
    for(int i=0;i<3;i++) {
      indexes.shuffle();
      Trash_Type.values.forEachIndexed((index, _type) {
        Trash_Item t = Trash_Item(
          _type,
          indexes[index]+_random.nextDouble(),
          _trash_start_y + (100*i)
        );
        _trash_items.add(t);
      });
    }

    for(Trash_Item i in _trash_items) {
      await add(i);
    }
  }
}