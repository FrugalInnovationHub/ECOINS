import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioPlayerComponent extends Component {
  @override
  Future<void> onLoad() async {
    FlameAudio.bgm.initialize();
    
    FlameAudio.audioCache.loadAll([
      'MUSICGAME.mp3',
      'GAME_SFX.mp3'
    ]);
    
    
    return super.onLoad();
  }

  void playBgm(String Filename) {
    FlameAudio.bgm.play(Filename);
  }

  void playSfx(String Filename) {
    FlameAudio.play(Filename);
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }
}