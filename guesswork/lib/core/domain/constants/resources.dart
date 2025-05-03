import 'package:audioplayers/audioplayers.dart';

const scratchSoundAudioResourcePath = 'sounds/scratching2.mp3';
const audienceCheeringClappingAudioResourcePath =
    'sounds/audience_cheering_clapping_short.mp3';
const partyPopperSoundResourcePath = 'sounds/party_popper.mp3';
const wrongAnswerSoundResourcePath = 'sounds/wrong_answer.mp3';

/// Enum representing audio assets with their corresponding paths
enum AudioAsset {
  scratch(scratchSoundAudioResourcePath),
  audienceCheering(audienceCheeringClappingAudioResourcePath),
  partyPopper(partyPopperSoundResourcePath),
  wrongAnswer(wrongAnswerSoundResourcePath);

  final String path;

  const AudioAsset(this.path);

  /// Returns an AssetSource for this audio asset
  AssetSource get source => AssetSource(path);
}
