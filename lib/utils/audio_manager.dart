import 'package:horror_story/models/audio_item.dart';
import 'package:synchronized/synchronized.dart';

class AudioManager {
  // AudioPlayer _player = new AudioPlayer();

  AudioItem _current;

  // play(AudioItem audio) async {
  //   if (audio == null) {
  //     return;
  //   }
  //
  //   var lock = new Lock();
  //   await lock.synchronized(() async {
  //     // TODO: try to compare using equals or some lib
  //     if (_current == null || _current.asset != audio.asset) {
  //       // await _player.setAsset(audio.asset);
  //       // await _player.setLoopMode(audio.loop ? LoopMode.all : LoopMode.off);
  //       // await _player.setVolume(1);
  //       //
  //       // await _player.play();
  //
  //       _current = audio;
  //     }
  //   });
  // }

  // stop() async {
  //   var lock = new Lock();
  //   await lock.synchronized(() async {
  //     if (_current != null) {
  //       await _player.stop();
  //
  //       _current = null;
  //     }
  //   });
  // }

  dispose() {
    // _player.dispose();
  }
}
