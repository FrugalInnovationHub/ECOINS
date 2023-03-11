import 'dart:math';
import 'package:ecoins/yellow_score.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';
import 'blue_score.dart';
import 'cocina.dart';
import 'banda_t.dart';
import 'gray_score.dart';
import 'green_score.dart';
import 'trash_items.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'pause_btn.dart';
import 'score_disp.dart';
import 'package:flame_audio/flame_audio.dart';

class EcoinsGame extends FlameGame with HasTappables, HasCollisionDetection{
  final Cocina _cocina = Cocina();
  final Basureros _basureros = Basureros();
  final Pause_Btn _pause_btn = Pause_Btn();
  final Score_Disp _score_disp = Score_Disp();
  final Green_Score_Disp _green_score_disp = Green_Score_Disp();
  final Blue_Score_Disp _blue_score_disp = Blue_Score_Disp();
  final Yellow_Score_Disp _yellow_score_disp = Yellow_Score_Disp();
  final Gray_Score_Disp _gray_score_disp = Gray_Score_Disp();
  final _random = new Random();
  final double _trash_start_y = 50;

  bool musicPlaying = false;

  var hole_pos = [
    Vector2(850, 100),
    Vector2(350, 200),
    Vector2(700, 300),
    // Vector2(800, 300)
  ];
  var banda_t_info = [
    [Vector2(0, 200), Vector2(350, 20)],
  ];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    children.register<PositionComponent>();
    // debugMode = true;

    await add(_cocina);
    await add(_pause_btn);
    await add(_score_disp);
    await add(_green_score_disp);
    await add(_blue_score_disp);
    await add(_yellow_score_disp);
    await add(_gray_score_disp);
    await add(_basureros);

    var _banda_t_holes = [];
    var _banda_ts = [];

    FlameAudio.bgm.initialize();
    if (!musicPlaying) {
      FlameAudio.bgm.play("MUSICGAME.mp3");
      musicPlaying = true;
    }
    for(Vector2 pos in hole_pos) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos;
      _banda_t_holes.add(_banda_t_hole);
      var _banda_1_info = [
        Vector2(0, _banda_t_hole.position.y),
        Vector2(_banda_t_hole.position.x, 20)
      ];

      var next_x = _banda_t_hole.position.x+_banda_t_hole.size.x;

      var _banda_2_info = [
        Vector2(next_x, _banda_t_hole.position.y),
        Vector2(this.size.length-next_x, 20)
      ];

      banda_t_info.add(_banda_1_info);
      banda_t_info.add(_banda_2_info);
    }

    for (Banda_T_Hole _hole in _banda_t_holes) {
      await add(_hole);
    }

    for(List info in banda_t_info) {
      Banda_T _bt = Banda_T(position: info[0], size: info[1]);
      _banda_ts.add(_bt);
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