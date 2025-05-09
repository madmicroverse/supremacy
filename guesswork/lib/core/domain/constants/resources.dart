import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

/// Enum representing audio assets with their corresponding paths
enum AudioAsset {
  scratch('sounds/scratching2.mp3'),
  audienceCheering('sounds/audience_cheering_clapping_short.mp3'),
  partyPopper('sounds/party_popper.mp3'),
  wrongAnswer('sounds/wrong_answer.mp3'),
  gameCompleteMusic('sounds/set_completed_background_music.mp3'),
  coinsIncreasing('sounds/coins_dropping.mp3'),
  inflating('sounds/inflating.mp3');

  final String path;

  const AudioAsset(this.path);

  /// Returns an AssetSource for this audio asset
  AssetSource get source => AssetSource(path);
}

/// Enum representing audio assets with their corresponding paths
enum ImageAsset {
  googleSignIn('assets/images/google_sign_in.png');

  final String path;

  const ImageAsset(this.path);

  /// Returns an AssetSource for this audio asset
  AssetImage get source => AssetImage(path);
}
