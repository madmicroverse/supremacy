import 'package:audioplayers/audioplayers.dart';

const scratchSoundAudioResourcePath = 'sounds/scratching2.mp3';
const audienceCheeringClappingAudioResourcePath =
    'sounds/audience_cheering_clapping_short.mp3';
const partyPopperSoundResourcePath = 'sounds/party_popper.mp3';
const wrongAnswerSoundResourcePath = 'sounds/wrong_answer.mp3';
const gameCompletedMusicPath = 'sounds/set_completed_background_music.mp3';
const coinsIncreasingSoundResourcePath = 'sounds/coins_dropping.mp3';
const inflatingSoundResourcePath = 'sounds/inflating.mp3';

/// Enum representing audio assets with their corresponding paths
enum AudioAsset {
  scratch(scratchSoundAudioResourcePath),
  audienceCheering(audienceCheeringClappingAudioResourcePath),
  partyPopper(partyPopperSoundResourcePath),
  wrongAnswer(wrongAnswerSoundResourcePath),
  gameCompleteMusic(gameCompletedMusicPath),
  coinsIncreasing(coinsIncreasingSoundResourcePath),
  inflating(inflatingSoundResourcePath);

  final String path;

  const AudioAsset(this.path);

  /// Returns an AssetSource for this audio asset
  AssetSource get source => AssetSource(path);
}
