import 'package:audioplayers/audioplayers.dart';

extension AudioPlayerUtils on AudioPlayer? {
  bool get safeResume {
    if (this?.state == PlayerState.paused ||
        this?.state == PlayerState.stopped) {
      this?.resume();
      return true;
    }
    return false;
  }

  bool get safeStop {
    if (this?.state == PlayerState.playing) {
      this?.stop();
      return true;
    }
    return false;
  }
}
