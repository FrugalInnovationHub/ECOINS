import 'dart:math';
import 'package:ecoins/components/ImageSprite.dart';
import 'package:ecoins/powerUpComponent.dart';
import 'package:ecoins/wheel.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'cocina.dart';
import 'banda_t.dart';
import 'gota_scored.dart';
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
  // final Score_Board _score_board = Score_Board();
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
  ];


  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<PositionComponent>();
    var ratio = size[0]/size[1];
    // debugMode = true;
    final ImageSprite Sol = ImageSprite(position: Vector2(ratio*40, ratio*350), size: Vector2.all(ratio*70), asset: 'Sol.png');
    final ImageSprite agua = ImageSprite(position: Vector2(ratio*125, ratio*350), size: Vector2(ratio*50, ratio*70), asset: 'Gota_agua.png');
    final Cocina _cocina = Cocina(size: size);
    await add(_cocina);
    await add(_pause_btn);
    await add(_score_disp);
    await add(_basureros);
    await add(Sol);
    await add(agua);

    var _banda_t_holes = [];
    var _banda_ts = [];
    var _banda_wheels = [];

    var wheel_pos = [
      Vector2(ratio, ratio*28),
      Vector2(ratio*125, ratio*28),
      Vector2(ratio*250, ratio*28),
      Vector2(ratio*375, ratio*28),
      Vector2(ratio, ratio*78),
      Vector2(ratio*125, ratio*78),
      Vector2(ratio*250, ratio*78),
      Vector2(ratio*375, ratio*78),
      Vector2(ratio, ratio*128),
      Vector2(ratio*125, ratio*128),
      // Vector2(ratio*225, ratio*128),
      Vector2(ratio*375, ratio*128)
    ];
    hole_pos.add(Vector2(ratio*100, ratio*50));
    hole_pos.add(Vector2(ratio*600, ratio*50));
    hole_pos.add(Vector2(ratio*300, ratio*150));

    for(var i=0; i<3; i++){
      hole_pos.add(Vector2(ratio*(285 + i*110) , ratio*250));
    }

    FlameAudio.bgm.play("MUSICGAME.mp3");

    // FlameAudio.bgm.initialize();
    // if (!musicPlaying) {
    //   FlameAudio.bgm.play("MUSICGAME.mp3");
    //   musicPlaying = true;
    // }

    Banda_T_Hole _banda_t_hole = Banda_T_Hole();
    _banda_t_hole.position = hole_pos[0];
    _banda_t_hole.size = Vector2(ratio*80, ratio*8);
    _banda_t_holes.add(_banda_t_hole);
    banda_t_info.add([Vector2(0, _banda_t_hole.position.y), Vector2(_banda_t_hole.position.x, ratio*40)]);
    Wheel wheel;

    for (Vector2 pos in wheel_pos) {
      wheel = Wheel(position: pos, size: Vector2(30, 30));
      _banda_wheels.add(wheel);
    }
    var last_y = _banda_t_hole.position.y;
    var last_x = _banda_t_hole.position.x+_banda_t_hole.size.x;
    for(Vector2 pos in hole_pos.sublist(1)) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos;
      _banda_t_hole.size = Vector2(ratio*80, ratio*8);
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

    for (Banda_T_Hole _hole in _banda_t_holes) {
      await add(_hole);
    }

    for(List info in banda_t_info) {
      var start_x = info[0][0];
      var end_x = info[1][0];
      while(start_x < end_x){
        if((start_x + ratio*80)  <= end_x) {
          Banda_T _bt = Banda_T(asset: 'conveyor_belt.png', position: Vector2(start_x, info[0][1]),
              size: Vector2(ratio * 80, info[1][1]));
          _banda_ts.add(_bt);
          start_x += ratio * 80;
        }
        else {
          Banda_T _bt = Banda_T(asset: 'uno_conveyor_belt.png', position: Vector2(start_x, info[0][1]),
              size: Vector2(ratio * 5, info[1][1]));
          _banda_ts.add(_bt);
          start_x += ratio*5;
        }
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
              ratio*(50 + i*100)
          );
        _trash_items.add(t);
      });
    }

    for(Trash_Item i in _trash_items) {
      await add(i);
    }

    for (Wheel wheel in _banda_wheels){
      await add(wheel);
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