import 'dart:ui';
import 'dart:io';

import 'package:ecoins/botella_vidrio.dart';
import 'package:ecoins/caja_jugo.dart';
import 'package:ecoins/caja_leche.dart';
import 'package:ecoins/caja_leche_purp.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'cocina.dart';
import 'banda_t.dart';
import 'botella_plastico.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'ecoins_logo.dart';

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection {
  final Cocina _cocina = Cocina();
  final Botella_Plastico _bp = Botella_Plastico();
  final Basureros _basureros = Basureros();
  final EcoinsLogo _ecoinsLogo = EcoinsLogo();
  final Caja_Jugo _caja_jugo = Caja_Jugo();
  final Caja_Leche _caja_leche = Caja_Leche();
  final Caja_Leche_Purp _caja_leche_purp = Caja_Leche_Purp();
  final Botella_Vidrio _botella_vidrio = Botella_Vidrio();

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
    await add(_ecoinsLogo);
    await add(_caja_jugo);
    await add(_caja_leche);
    await add(_caja_leche_purp);
    await add(_botella_vidrio);
  }
}