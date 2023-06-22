import 'dart:math';
import 'package:ecoins/blue_score.dart';
import 'package:ecoins/components/TutorialAnimation.dart';
import 'package:ecoins/components/ImageSprite.dart';
import 'package:ecoins/components/basuresos_lock.dart';
import 'package:ecoins/components/distractive_item.dart';
import 'package:ecoins/hbox_level3.dart';
import 'package:ecoins/powerUpComponent.dart';
import 'package:ecoins/screens/pause_menu.dart';
import 'package:ecoins/sol_scored.dart';
import 'package:ecoins/wheel.dart';
import 'package:ecoins/yellow_score.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'cocina.dart';
import 'banda_t.dart';
import 'globals.dart';
import 'gota_scored.dart';
import 'gray_score.dart';
import 'hbox_level2.dart';
import 'trash_items.dart';
import 'banda_t_hole.dart';
import 'basureros.dart';
import 'pause_btn.dart';
import 'score_disp.dart';
import 'package:flame_audio/flame_audio.dart';

class EcoinsGame extends FlameGame with HasTappables,HasDraggables, HasCollisionDetection, HasGameRef, WidgetsBindingObserver{

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  final Basureros _basureros = Basureros();
  final Pause_Btn _pause_btn = Pause_Btn();
  final Sol_Score_Disp _sol_score_disp = Sol_Score_Disp();
  final Gota_Score_Disp _gota_score_disp = Gota_Score_Disp();
  final Score_Disp _score_disp = Score_Disp();
  final Blue_Score_Disp blue_score_disp = Blue_Score_Disp();
  final Yellow_Score_Disp yellow_score_disp = Yellow_Score_Disp();
  final Gray_Score_Disp gray_score_disp = Gray_Score_Disp();
  late BasuresosLock lock;
  // final Score_Board _score_board = Score_Board();
  final _random = new Random();
  late PowerUp_Type_Comp type;
  var focusedItem = "Plastico" ;
  late final total_trash_items;
  late var ratio;
  late OpacityEffect h_opacity_blink_effect_yellow;
  late OpacityEffect h_opacity_blink_effect_grey;
  late MoveEffect h_move_effect_new;
  late double speed = 24.0;
  Cocina _cocina = Cocina();
  ImageSprite Sol = ImageSprite();
  ImageSprite agua = ImageSprite();
  late TutorialAnimation animation;

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
    WidgetsBinding.instance.addObserver(this);
    // ratio = double.parse((size[0]/size[1]).toStringAsFixed(1));

    var y = (size[0] / 16)*9;
    camera.viewport = FixedResolutionViewport(Vector2(size[0], y));
    // debugMode = true;
    focusedItem = "Plastico";
    total_trash_items = 5;

    animation = TutorialAnimation(
        text_url: "start_playing.png",
        position: Vector2(size[0]*0.13, size[1]*0.37),
        size: Vector2(size[0]*0.4, size[1]*0.25),
        audio_url: "start_playing.mp3",
        align: "left",
        is_girl_image: true);

    _cocina = Cocina(size: Vector2(size[0], size[1]));
    await add(_cocina);
    await add(_pause_btn);
    await add(hbox_level3(size: Vector2(size[0]*0.025 ,size[1]*0.1), position: Vector2(-(size[0]*0.06),size[1]*0.45)));
    await add(hbox_level3(size: Vector2(size[0]*0.22,size[1]*0.1), position: Vector2(size[0],size[1]*0.45)));
    await add(_score_disp);
    await add(_basureros);
    await add(blue_score_disp);
    await add(yellow_score_disp);
    await add(gray_score_disp);
    Sol = ImageSprite(position: Vector2(size[0]*0.05, size[1]*0.75), size: Vector2.all(size[0]*0.09), asset: 'Sol.png');
    agua = ImageSprite(position: Vector2(size[0]*0.160, size[1]*0.75), size: Vector2(size[0]*0.06, size[1]*0.15), asset: 'Gota_agua.png');
    await add(Sol);
    await add(agua);
    await add(_sol_score_disp);
    await add(_gota_score_disp);

    Future.delayed(Duration(seconds: 3), () async { await add(animation);  } );


    lock = BasuresosLock(position: Vector2(size[0]*0.605, size[1]*0.655), size: Vector2(size[0]*0.104, size[1]*0.33), type: "yellow");
    await add(lock);
    lock = BasuresosLock(position: Vector2(size[0]*0.74, size[1]*0.655), size: Vector2(size[0]*0.104, size[1]*0.33), type: "gray");
    await add(lock);
    h_opacity_blink_effect_yellow = OpacityEffect.to(2, EffectController(duration: 1, repeatCount: 3, startDelay: 0));
    h_opacity_blink_effect_grey = OpacityEffect.to(2, EffectController(duration: 1, repeatCount: 3, startDelay: 0));

    var _banda_t_holes = [];
    var _banda_ts = [];
    var _banda_wheels = [];

    var wheel_pos = [
      Vector2(size[0]*0.01, size[1]*0.062),
      Vector2(size[0]*0.155, size[1]*0.062),
      Vector2(size[0]*0.31, size[1]*0.062),
      Vector2(size[0]*0.45, size[1]*0.062),
      Vector2(size[0]*0.01, size[1]*0.162),
      Vector2(size[0]*0.155, size[1]*0.162),
      Vector2(size[0]*0.31, size[1]*0.162),
      Vector2(size[0]*0.45, size[1]*0.162),
      Vector2(size[0]*0.01, size[1]*0.26),
      Vector2(size[0]*0.155, size[1]*0.26),
      // Vector2(ratio*225, ratio*128),
      Vector2(size[0]*0.45, size[1]*0.26)
    ];
    hole_pos.add([Vector2(size[0]*0.1, size[1]*0.11),0]);
    hole_pos.add([Vector2(size[0]*0.75, size[1]*0.11),0]);
    hole_pos.add([Vector2(size[0]*0.375, size[1]*0.31),0]);
    // hole_pos.add(Vector2(ratio*(390) , ratio*230));
    for(var i=0; i<3; i++){
      hole_pos.add([Vector2(size[0]*(0.487 + i*0.135) , size[1]*0.505), i+1]);
    }

    // FlameAudio.bgm.play("MUSICGAME.mp3");

    FlameAudio.bgm.initialize();
    if (!musicPlaying) {
      FlameAudio.bgm.play("BackgroundMusic.mp3");
      musicPlaying = true;
    }

    Banda_T_Hole _banda_t_hole = Banda_T_Hole();
    _banda_t_hole.position = hole_pos[0][0];
    _banda_t_hole.size = Vector2(size[0]*0.06, size[1]*0.02);
    _banda_t_hole.hole_no = hole_pos[0][1];
    _banda_t_holes.add(_banda_t_hole);
    banda_t_info.add([Vector2(0, _banda_t_hole.position.y), Vector2(_banda_t_hole.position.x, size[1]*0.085)]);
    Wheel wheel;

    for (Vector2 pos in wheel_pos) {
      wheel = Wheel(position: pos, size: Vector2.all(size[1]*0.035));
      _banda_wheels.add(wheel);
    }
    var last_y = _banda_t_hole.position.y;
    var last_x = _banda_t_hole.position.x+_banda_t_hole.size.x;
    for(var pos in hole_pos.sublist(1)) {
      Banda_T_Hole _banda_t_hole = Banda_T_Hole();
      _banda_t_hole.position = pos[0];
      _banda_t_hole.size = Vector2(size[0]*0.06, size[1]*0.02);
      _banda_t_hole.hole_no = pos[1];
      _banda_t_holes.add(_banda_t_hole);
      // var _banda_1_info = [
      //   Vector2(0, _banda_t_hole.position.y),
      //   Vector2(_banda_t_hole.position.x, 20)
      // ];
      var _banda_info;
      if(last_y == _banda_t_hole.position.y){
        _banda_info = [
          Vector2(last_x, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, size[1]*0.085)
        ];
      }
      else {
        banda_t_info.add([
          Vector2(last_x, last_y),
          Vector2(this.size.length, size[1]*0.085)
        ]);
        _banda_info = [
          Vector2(0, _banda_t_hole.position.y),
          Vector2(_banda_t_hole.position.x, size[1]*0.085)
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
      Vector2(this.size.length, size[1]*0.085)
    ]);

    for (Banda_T_Hole _hole in _banda_t_holes.sublist(0,_banda_t_holes.length - 2)) {
      await add(_hole);
    }

    for(List info in banda_t_info) {
      var start_x = info[0][0];
      var end_x = info[1][0];
      while(start_x < end_x){
        if((start_x + size[0]*0.1)  <= end_x) {
          Banda_T _bt = Banda_T(asset: 'conveyor_belt.png', position: Vector2(start_x, info[0][1]),
              size: Vector2(size[0]*0.101, info[1][1]));
          _banda_ts.add(_bt);
          start_x += size[0]*0.1;
        }
        else {
          Banda_T _bt = Banda_T(asset: 'uno_conveyor_belt.png', position: Vector2(start_x, info[0][1]),
              size: Vector2(size[0] * 0.006, info[1][1]));
          _banda_ts.add(_bt);
          start_x += size[0] * 0.005;
        }
      }
    }

    var hole_no = 1;
    for(var hole in hole_pos.sublist(hole_pos.length-2)){
      var start_x = hole[0][0];
      var end_x = hole[0][0] + size[0]*0.06;
      Banda_T _bt;
      while(start_x < end_x){
        _bt = Banda_T(asset: 'uno_conveyor_belt.png', position: Vector2(start_x, hole[0][1]),
            size: Vector2(size[0] * 0.006, size[1]*0.085), hole_no: hole_no);
        _banda_ts.add(_bt);
        start_x += size[0] * 0.005;
      }
      hole_no += 1;
    }

    for(Banda_T _bt in _banda_ts) {
      await add(_bt);
    }

    var belt1_trash_items = [];
    var belt2_trash_items = [];
    // var distractive_items = [];
    var focused_indexes = [];
    var rest_indexes = [];
    Trash_Type.values.forEachIndexed((index, element) {
      if(element.type == focusedItem){
        focused_indexes.add(index);
      }
      else {
        rest_indexes.add(index);
      }
    });
    // var indexes = Trash_Type.values.mapIndexed((index, element) => index).toList();
    var dis_indexes = Distractive_Type.values.mapIndexed((index, element) => index).toList();

    for(int i=0;i < (0.6*total_trash_items).round() ;i++) {
      var j = _random.nextInt(focused_indexes.length);
        Trash_Item t;
        t = Trash_Item(
              Trash_Type.values[focused_indexes[j]],
              i*4,
              size[1]*0.11,
              0,
              speed
          );
        belt1_trash_items.add(t);
        j = _random.nextInt(focused_indexes.length);
        t = Trash_Item(
            Trash_Type.values[focused_indexes[j]],
            i*4,
            size[1]*0.31,
            0,
            speed
        );
        belt2_trash_items.add(t);
    }
    for(int i=0;i < (0.4*total_trash_items).round() ;i++) {
      var j = _random.nextInt(rest_indexes.length);
      Trash_Item t;
      t = Trash_Item(
          Trash_Type.values[rest_indexes[j]],
          i*4,
          size[1]*0.11,
          0,
          speed
      );
      belt1_trash_items.add(t);
      j = _random.nextInt(rest_indexes.length);
      t = Trash_Item(
          Trash_Type.values[rest_indexes[j]],
          i*4,
          size[1]*0.31,
          0,
          speed
      );
      belt2_trash_items.add(t);
    }



    for (int i = 0; i < 2; i++){
      var k = _random.nextInt(dis_indexes.length);
      DistractiveItem d;
      d = DistractiveItem(
          Distractive_Type.values[k],
          i*4 + 2,
          size[1]*0.11
      );
      belt1_trash_items.add(d);
      k = _random.nextInt(dis_indexes.length);
      d = DistractiveItem(
          Distractive_Type.values[k],
          i*4 + 2,
          size[1]*0.31
      );
      belt2_trash_items.add(d);
    }

    belt1_trash_items.shuffle();
    belt2_trash_items.shuffle();
    for(int i = 0; i < belt1_trash_items.length; i++) {
      belt1_trash_items[i].delay = (i*3 + _random.nextInt(3)).toDouble();
      belt2_trash_items[i].delay = (i*3 + _random.nextInt(3)).toDouble();
      await add(belt1_trash_items[i]);
      await add(belt2_trash_items[i]);
    }

    // for(var i in distractive_items) {
    //   await add(i);
    // }

    for (Wheel wheel in _banda_wheels){
      await add(wheel);
    }

    var _powerup_items = [];
    var indexes_powerup = PowerUp_Type_Comp.values.mapIndexed((index, element) => index).toList();
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    if (isBackground) {
      overlays.add("PauseMenu");
      pauseEngine();
      FlameAudio.bgm.pause();
    }
  }


  @override
  void onChildrenChanged(Component child, ChildrenChangeType type) {
    // TODO: implement onChildrenChanged
    super.onChildrenChanged(child, type);
    if(child is TutorialAnimation && type == ChildrenChangeType.removed){
      if(child.text_url == "Lvl3_1.png") {
        animation = TutorialAnimation(
            text_url: "Lvl3_2.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.23),
            audio_url: "Lvl3_2.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }
    }
    if(child is Trash_Item && type == ChildrenChangeType.removed){
      if((blue_score_disp.blue_score == 2) || (yellow_score_disp.yellow_score == 2 && child.category == "Aluminio") || (gray_score_disp.gray_score == 2 && child.category == "Paper")){
        animation = TutorialAnimation(
            text_url: "SUN_AND_WATER.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.23),
            audio_url: "SUN_AND_WATER.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }


      final allTrashItems = children.query<Trash_Item>();
      var focused_items_count = 0;
      var belt1_item_count = 0;
      for(var i in allTrashItems){

        if(i.category == focusedItem){
          focused_items_count += 1;
        }
        if(i.y_loc < size[1]*0.11){
          belt1_item_count += 1;
        }
      }
      var focused_indexes = [];
      var rest_indexes = [];
      Trash_Type.values.forEachIndexed((index, element) {
        if(element.type == focusedItem){
          focused_indexes.add(index);
        }
        else {
          rest_indexes.add(index);
        }
      });
      Trash_Item t;
      var j;
      if(focused_items_count < ((1.2)*total_trash_items).round()){
        j = _random.nextInt(focused_indexes.length);
        t = Trash_Item(
            Trash_Type.values[focused_indexes[j]],
            _random.nextDouble() + _random.nextInt(5),
            size[1]*0.11,
            0,
            speed
        );
      }
      else {
        j = _random.nextInt(rest_indexes.length);
        t = Trash_Item(
            Trash_Type.values[rest_indexes[j]],
            _random.nextDouble() + _random.nextInt(5),
            size[1]*0.11,
            0,
            speed
        );
      }
      if(belt1_item_count < total_trash_items){
        add(t);
      }
      else {
        t.y_loc = size[1]*0.31;
        add(t);
      }
      if(blue_score_disp.blue_score >= 40 && focusedItem != "Aluminio"){
        focusedItem = "Aluminio";
        final allBandaT = children.query<Banda_T>();
        final allLock = children.query<BasuresosLock>();
        final belt_items = children.query<Trash_Item>();
        speed = 16.0;

        for(var i in allBandaT){
          if(i.hole_no == 1){
            i.removeFromParent();
          }
        }
        for (var i in allLock){
          if(i.type == "yellow"){
            i.removeFromParent();
            FlameAudio.play(Globals.newBinUnlock);
            _basureros.Yellow.add(h_opacity_blink_effect_yellow);
            Future.delayed(Duration(seconds: 3), () {
              yellow_score_disp.addLevels();
            });
          }
        }
        animation = TutorialAnimation(
            text_url: "Lvl2_1.png",
            position: Vector2(size[0]*0.13, size[1]*0.37),
            size: Vector2(size[0]*0.45, size[1]*0.25),
            audio_url: "Lvl2_1.mp3",
            align: "left",
            is_girl_image: true);
        Future.delayed(Duration(seconds: 3), () { add(animation); });

        Banda_T_Hole _banda_t_hole = Banda_T_Hole();
        _banda_t_hole.position = hole_pos[4][0];
        _banda_t_hole.size = Vector2(size[0]*0.06, size[1]*0.02);
        _banda_t_hole.hole_no = 2;
        add(_banda_t_hole);
      }
      if(yellow_score_disp.yellow_score >= 40 && focusedItem != "Paper"){
        print("entered gray");
        focusedItem = "Paper";
        final allBandaT = children.query<Banda_T>();
        final allLock = children.query<BasuresosLock>();
        speed = 12.0;

        for(var i in allBandaT){
          if(i.hole_no == 2){
            i.removeFromParent();
          }
        }
        for (var i in allLock){
          if(i.type == "gray"){
            i.removeFromParent();
            FlameAudio.play(Globals.newBinUnlock);
            _basureros.Grey.add(h_opacity_blink_effect_grey);
            Future.delayed(Duration(seconds: 3), () {
              gray_score_disp.addLevels();
            });
          }
        }
        animation = TutorialAnimation(
            text_url: "Lvl3_1.png",
            position: Vector2(size[0]*0.13, size[1]*0.37),
            size: Vector2(size[0]*0.45, size[1]*0.25),
            audio_url: "Lvl3_1.mp3",
            align: "left",
            is_girl_image: true);
        Future.delayed(Duration(seconds: 3), () { add(animation); });
        Banda_T_Hole _banda_t_hole = Banda_T_Hole();
        _banda_t_hole.position = hole_pos[5][0];
        _banda_t_hole.size = Vector2(size[0]*0.06, size[1]*0.02);
        _banda_t_hole.hole_no = 3;
        add(_banda_t_hole);
      }
      if(blue_score_disp.blue_score == 30) {
        animation = TutorialAnimation(
            text_url: "Lvl1_2.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.23),
            audio_url: "Lvl1_2.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }

      if(yellow_score_disp.yellow_score == 10){
        animation = TutorialAnimation(
            text_url: "Lvl2_2.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.25),
            audio_url: "Lvl2_2.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }
      if(yellow_score_disp.yellow_score == 30){
        animation = TutorialAnimation(
            text_url: "Lvl2_3.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.25),
            audio_url: "Lvl2_3.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }
      if(gray_score_disp.gray_score == 30){
        animation = TutorialAnimation(
            text_url: "Lvl3_3.png",
            position: Vector2(size[0]*0.37, size[1]*0.25),
            size: Vector2(size[0]*0.5, size[1]*0.23),
            audio_url: "Lvl3_3.mp3",
            align: "right",
            is_girl_image: true);
        add(animation);
      }
    }

    if(child is DistractiveItem && type == ChildrenChangeType.removed){
      var dis_indexes = Distractive_Type.values.mapIndexed((index, element) => index).toList();
      var k = _random.nextInt(dis_indexes.length);
      DistractiveItem d;
      if(child.y_loc <= size[1]*0.11) {
        d = DistractiveItem(
            Distractive_Type.values[k], _random.nextDouble() + _random.nextInt(5), size[1]*0.11);
      }
      else {
        d = DistractiveItem(
            Distractive_Type.values[k], _random.nextDouble() + _random.nextInt(5), size[1]*0.31);
      }
      add(d);
    }

    if(child is PowerUpComponent && type == ChildrenChangeType.removed){
      PowerUpComponent t;
      t = PowerUpComponent(child.type, 5, child.y_loc);
      Future.delayed(Duration(seconds: _random.nextInt(5) + 1), () => add(t));

    }
  }
}