import 'dart:math';
import 'package:ecoins/powerUpComponent.dart';
import 'package:ecoins/score_board.dart';
import 'package:ecoins/sol_scored.dart';
import 'package:ecoins/yellow_score.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';
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

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection, HasGameRef{
  final Cocina _cocina = Cocina();
  final Basureros _basureros = Basureros();
  final Pause_Btn _pause_btn = Pause_Btn();
  final Score_Disp _score_disp = Score_Disp();
  final Green_Score_Disp _green_score_disp = Green_Score_Disp();
  final Sol_Score_Disp _sol_score_disp = Sol_Score_Disp();
  final Gota_Score_Disp _gota_score_disp = Gota_Score_Disp();
  final Blue_Score_Disp _blue_score_disp = Blue_Score_Disp();
  final Yellow_Score_Disp _yellow_score_disp = Yellow_Score_Disp();
  final Gray_Score_Disp _gray_score_disp = Gray_Score_Disp();
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
    // debugMode = true;

    await add(_cocina);
    await add(_score_board);
    await add(_pause_btn);
    await add(_score_disp);
    await add(_green_score_disp);
    await add(_blue_score_disp);
    await add(_sol_score_disp);
    await add(_gota_score_disp);
    await add(_yellow_score_disp);
    await add(_gray_score_disp);
    await add(_basureros);

    var _banda_t_holes = [];
    var _banda_ts = [];


    hole_pos.add(Vector2(2*this.size[0]/3, this.size[1]/8));
    hole_pos.add(Vector2(1*this.size[0]/3, this.size[1]/4));
    for(var i=0; i<4; i++){
      hole_pos.add(Vector2(this.size[0]/4 + i*this.size[1]/4 + 10,this.size[1]/2.5));
    }

    FlameAudio.bgm.play("MUSICGAME.mp3");


    Banda_T_Hole _banda_t_hole = Banda_T_Hole();
    _banda_t_hole.position = hole_pos[0];
    _banda_t_hole.size = Vector2(this.size[1]/4 - 20, 20);
    _banda_t_holes.add(_banda_t_hole);
    banda_t_info.add([Vector2(0, _banda_t_hole.position.y), Vector2(_banda_t_hole.position.x, 20)]);
    var last_y = _banda_t_hole.position.y;
    var last_x = _banda_t_hole.position.x+_banda_t_hole.size.x;
    for(Vector2 pos in hole_pos.sublist(1)) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos;
      _banda_t_hole.size = Vector2(this.size[1]/4 - 20, 20);
      _banda_t_holes.add(_banda_t_hole);
      // var _banda_1_info = [
      //   Vector2(0, _banda_t_hole.position.y),
      //   Vector2(_banda_t_hole.position.x, 20)
      // ];
      var _banda_info;
      if(last_y == _banda_t_hole.position.y){
        _banda_info = [
          Vector2(last_x, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, 20)
        ];
      }
      else {
        banda_t_info.add([
          Vector2(last_x, last_y),
          Vector2(this.size.length, 20)
        ]);
        _banda_info = [
          Vector2(0, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, 20)
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
      Vector2(this.size.length, 20)
    ]);

    for (Banda_T_Hole _hole in _banda_t_holes) {
      await add(_hole);
    }

    for(List info in banda_t_info) {
      var start_x = info[0][0];
      var end_x = info[1][0];
      while(start_x < end_x){
        Banda_T _bt = Banda_T(position: Vector2(start_x, info[0][1]), size: Vector2(12, info[1][1]));
        _banda_ts.add(_bt);
        start_x += 12;
      }
    }

    for(Banda_T _bt in _banda_ts) {
      await add(_bt);
    }

    var _trash_items = [];
    var indexes = Trash_Type.values.mapIndexed((index, element) => index).toList();

    // Generate 3 levels of trash items
    for(int i=1;i<4;i++) {
      indexes.shuffle();
      Trash_Type.values.forEachIndexed((index, _type) {
        Trash_Item t;
        if(i == 3){
          t = Trash_Item(
              _type,
              indexes[index] + _random.nextDouble(),
              (this.size[1] / 2.5) - _trash_start_y
          );
        }
        else {

          t = Trash_Item(
              _type,
              indexes[index] + _random.nextDouble(),
              (i * this.size[1] / 8) - _trash_start_y
          );
        }
        _trash_items.add(t);
      });
    }

    for(Trash_Item i in _trash_items) {
      await add(i);
    }

    var _powerup_items = [];
    var indexes_powerup = PowerUp_Type_Comp.values.mapIndexed((index, element) => index).toList();
    indexes.shuffle();
    PowerUp_Type_Comp.values.forEachIndexed((index, _type) {
      PowerUpComponent t;
        t = PowerUpComponent(
            _type,
            indexes_powerup[index] + _random.nextDouble(),
            (this.size[1] / 2.5)
        );
        t = PowerUpComponent(
            _type,
            indexes_powerup[index] + _random.nextDouble(),
            (this.size[1] / 8)
        );

      _powerup_items.add(t);
    });
    for(PowerUpComponent i in _powerup_items) {
      await add(i);
    }
  }
}