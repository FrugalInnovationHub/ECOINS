import 'dart:math';
import 'package:ecoins/powerUpComponent.dart';
import 'package:ecoins/score_board.dart';
import 'package:ecoins/sol_scored.dart';
import 'package:ecoins/yellow_score.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'blue_score.dart';
import 'cocina.dart';
import 'banda_t.dart';
import 'gota_scored.dart';
import 'gray_score.dart';
import 'green_score.dart';
import 'trash_items.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'pause_btn.dart';
import 'score_disp.dart';
import 'package:flame_audio/flame_audio.dart';

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection{

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  final Basureros _basureros = Basureros();
  final Pause_Btn _pause_btn = Pause_Btn();
  final Score_Disp _score_disp = Score_Disp();
  final Score_Board _score_board = Score_Board();
  final _random = new Random();
  final double _trash_start_y = 50;
  final double _powerup_start_y = -30;
  late PowerUp_Type_Comp type;

  bool musicPlaying = false;

  var hole_pos = [
    // Vector2(850, 100),
    // Vector2(350, 200),
    // Vector2(700, 300),
    // Vector2(800, 300)
  ];
  var banda_t_info = [
    // [Vector2(0, 200), Vector2(350, 20)],
  ];


  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<PositionComponent>();
    var ratio = size[0]/size[1];
    // debugMode = true;
    final Cocina _cocina = Cocina(size: size);
    await add(_cocina);
    await add(_pause_btn);
    await add(_score_disp);
    await add(_basureros);

    var _banda_t_holes = [];
    var _banda_ts = [];


    hole_pos.add(Vector2(ratio*200, ratio*50));
    hole_pos.add(Vector2(ratio*500, ratio*50));
    hole_pos.add(Vector2(ratio*350, ratio*150));

    for(var i=0; i<3; i++){
      hole_pos.add(Vector2(ratio*(350 + i*110) , ratio*250));
    }

    FlameAudio.bgm.play("MUSICGAME.mp3");

    // FlameAudio.bgm.initialize();
    // if (!musicPlaying) {
    //   FlameAudio.bgm.play("MUSICGAME.mp3");
    //   musicPlaying = true;
    // }

    Banda_T_Hole _banda_t_hole = Banda_T_Hole();
    _banda_t_hole.position = hole_pos[0];
    _banda_t_hole.size = Vector2(ratio*80, 20);
    _banda_t_holes.add(_banda_t_hole);
    banda_t_info.add([Vector2(0, _banda_t_hole.position.y), Vector2(_banda_t_hole.position.x, ratio*40)]);
    var last_y = _banda_t_hole.position.y;
    var last_x = _banda_t_hole.position.x+_banda_t_hole.size.x;
    for(Vector2 pos in hole_pos.sublist(1)) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos;
      _banda_t_hole.size = Vector2(ratio*80, 20);
      _banda_t_holes.add(_banda_t_hole);
      // var _banda_1_info = [
      //   Vector2(0, _banda_t_hole.position.y),
      //   Vector2(_banda_t_hole.position.x, 20)
      // ];
      var _banda_info;
      if(last_y == _banda_t_hole.position.y){
        _banda_info = [
          Vector2(last_x, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, ratio*40)
        ];
      }
      else {
        banda_t_info.add([
          Vector2(last_x, last_y),
          Vector2(this.size.length, ratio*40)
        ]);
        _banda_info = [
          Vector2(0, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, ratio*40)
        ];
      }
      last_y = _banda_t_hole.position.y;
      last_x = _banda_t_hole.position.x+_banda_t_hole.size.x;

      // var _banda_2_info = [
      //   Vector2(next_x, _banda_t_hole.position.y),
      //   Vector2(this.size.length, 20)
      // ];
      banda_t_info.add(_banda_info);
      // banda_t_info.add(_banda_2_info);
    }

    banda_t_info.add([
      Vector2(last_x, last_y),
      Vector2(this.size.length, ratio*40)
    ]);

    // for (Banda_T_Hole _hole in _banda_t_holes) {
    //   await add(_hole);
    // }

    for(List info in banda_t_info) {
      var start_x = info[0][0];
      var end_x = info[1][0];
      while(start_x < end_x){
        Banda_T _bt = Banda_T(position: Vector2(start_x, info[0][1]), size: Vector2(ratio*80, info[1][1]));
        _banda_ts.add(_bt);
        start_x += ratio*80;
      }
    }

    for(Banda_T _bt in _banda_ts) {
      await add(_bt);
    }

    var _trash_items = [];
    var indexes = Trash_Type.values.mapIndexed((index, element) => index).toList();

    // Generate 3 levels of trash items
    for(int i=0;i<3;i++) {
      indexes.shuffle();
      Trash_Type.values.forEachIndexed((index, _type) {
        Trash_Item t;
        t = Trash_Item(
              _type,
              indexes[index] + _random.nextDouble(),
              ratio*(15 + i*100)
          );
        _trash_items.add(t);
      });
    }

    for(Trash_Item i in _trash_items) {
      await add(i);
    }

    // var _powerup_items = [];
    // var indexes_powerup = PowerUp_Type_Comp.values.mapIndexed((index, element) => index).toList();
    // indexes.shuffle();
    // PowerUp_Type_Comp.values.forEachIndexed((index, _type) {
    //   PowerUpComponent t;
    //     t = PowerUpComponent(
    //         _type,
    //         indexes_powerup[index] + _random.nextDouble(),
    //         (this.size[1] / 2.5)
    //     );
    //     t = PowerUpComponent(
    //         _type,
    //         indexes_powerup[index] + _random.nextDouble(),
    //         (this.size[1] / 8)
    //     );
    //
    //   _powerup_items.add(t);
    // });
    // for(PowerUpComponent i in _powerup_items) {
    //   await add(i);
    // }
  }
}