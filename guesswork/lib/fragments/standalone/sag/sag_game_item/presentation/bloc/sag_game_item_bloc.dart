import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/constants/resources.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/extension/audio_player.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart';

import 'sag_game_item_be.dart';
import 'sag_game_item_bs.dart';

class SAGGameItemBloc extends Bloc<SAGGameItemBE, SAGGameItemBS> {
  final IRouter _router;
  final GetNetworkImageUseCase _getNetworkImageUseCase;
  final GetGamesSettingsUseCase _getGamesSettingsUseCase;

  Set<Offset> concealedPoints = {};
  Set<Offset> pathPoints = {};
  late int concealablePointsNum;
  final int _samplingResolution = 200;
  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;

  ConfettiController confettiController;
  AudioPlayer? scratchSoundPlayer;
  AudioPlayer? crowdCheeringPlayer;
  AudioPlayer? partyPopperPlayer;
  AudioPlayer? wrongAnswerPlayer;

  SAGGameItemBloc(
    this._router,
    this._getNetworkImageUseCase,
    this._getGamesSettingsUseCase,
  ) : confettiController = ConfettiController(duration: 800.ms),
      super(SAGGameItemBS()) {
    on<InitSAGGameItemBE>(_initSAGGameItemBE);
    on<InitGamesImageBE>(_initGamesImageBE);
    on<InitPathBE>(_initPathBE);
    on<AddPathPointBE>(_addPathPointBE);
    on<InitGameSettingsBE>(_initGameSettingsBE);
    on<GamesSettingsUpdateBE>(_gamesSettingsUpdateBE);
    on<GuessSAGGameItemBE>(_guessBlocEvent);
    on<ContinueSAGGameItemBE>(_continueBlocEvent);
    on<InitAudioPlayersBE>(_initAudioPlayersBE);
    on<StopScratchPlayerBE>(_stopScratchPlayerBE);
  }

  /*
  Events ↓
   */
  FutureOr<void> _initSAGGameItemBE(event, emit) async {
    emit(state.withSagGameItem(event.sagGameItem));
    add(InitAudioPlayersBE());
    add(InitGamesImageBE(event.sagGameItem.guessImageUrl));
    add(InitGameSettingsBE());
  }

  FutureOr<void> _initAudioPlayersBE(event, emit) async {
    scratchSoundPlayer = AudioPlayer();
    scratchSoundPlayer?.setReleaseMode(ReleaseMode.loop);
    await scratchSoundPlayer?.setSource(AudioAsset.scratch.source);

    crowdCheeringPlayer = AudioPlayer();
    crowdCheeringPlayer?.setVolume(1);
    crowdCheeringPlayer?.setReleaseMode(ReleaseMode.release);
    await crowdCheeringPlayer?.setSource(AudioAsset.audienceCheering.source);

    partyPopperPlayer = AudioPlayer();
    partyPopperPlayer?.setVolume(1);
    partyPopperPlayer?.setReleaseMode(ReleaseMode.release);
    await partyPopperPlayer?.setSource(AudioAsset.partyPopper.source);

    wrongAnswerPlayer = AudioPlayer();
    wrongAnswerPlayer?.setVolume(1);
    wrongAnswerPlayer?.setReleaseMode(ReleaseMode.release);
    await wrongAnswerPlayer?.setSource(AudioAsset.wrongAnswer.source);
  }

  FutureOr<void> _initGamesImageBE(event, emit) async {
    final result = await _getNetworkImageUseCase(event.url);
    switch (result) {
      case Success():
        return emit(state.withGamesImage(result.data));
      case Error():
        throw UnimplementedError();
    }
  }

  FutureOr<void> _initGameSettingsBE(event, emit) async {
    final result = await _getGamesSettingsUseCase();
    switch (result) {
      case Success():
        _gamesSettingsSubscription = result.data.listen((gamesSettings) {
          add(GamesSettingsUpdateBE(gamesSettings));
        });
      case Error():
        switch (result.error) {
          default:
          // return emit(state.errorState(result.error.toString()));
        }
    }
  }

  FutureOr<void> _initPathBE(InitPathBE event, Emitter<SAGGameItemBS> emit) {
    Path revealedPath =
        Path()..addRect(Rect.fromLTWH(0, 0, event.width, event.height));

    final xStep = event.width / _samplingResolution;
    final yStep = event.height / _samplingResolution;

    var concealedPoints = <Offset>{};
    for (var x = 0; x < _samplingResolution; x++) {
      for (var y = 0; y < _samplingResolution; y++) {
        concealedPoints.add(Offset(x * xStep, y * yStep));
      }
    }

    concealablePointsNum = concealedPoints.length;

    emit(state.withRevealedPath(revealedPath));
  }

  FutureOr<void> _addPathPointBE(event, emit) {
    scratchSoundPlayer.safeResume;

    pathPoints.add(event.point);

    final brushRadius = 30.0;
    final newRevealPath =
        Path()..addOval(
          Rect.fromCircle(
            center: Offset(event.point.dx, event.point.dy),
            radius: brushRadius,
          ),
        );

    final updatedRevealedPath = Path.combine(
      PathOperation.difference,
      state.revealedPath!,
      newRevealPath,
    );

    concealedPoints.removeWhere(
      (checkpoint) => _inCircle(checkpoint, event.point, brushRadius),
    );
    final newRevealedRatio = concealedPoints.length / concealablePointsNum;
    emit(
      state
          .withRevealedPath(updatedRevealedPath)
          .withRevealedRatio(newRevealedRatio),
    );
  }

  bool _inCircle(Offset center, Offset point, double radius) {
    final dX = center.dx - point.dx;
    final dY = center.dy - point.dy;
    final h = dX * dX + dY * dY;
    return h <= pow(radius, 2);
  }

  FutureOr<void> _gamesSettingsUpdateBE(event, emit) {
    emit(state.withGamesSettings(event.gamesSettings));
  }

  FutureOr<void> _guessBlocEvent(event, emit) {
    final guessGame = state.sagGameItem!;
    final guessGameAnswer = SAGGameItemAnswer(
      guessGameId: guessGame.id,
      guessGameVersion: guessGame.version,
      answerOptionId: event.guess.id,
      isCorrect: guessGame.answer == event.guess.id,
      points: guessGame.points,
    );
    if (guessGameAnswer.isCorrect) {
      partyPopperPlayer.safeResume;
      crowdCheeringPlayer.safeResume;
      confettiController.play();
    } else {
      wrongAnswerPlayer.safeResume;
    }
    emit(state.withSAGGameItemAnswer(guessGameAnswer));
  }

  FutureOr<void> _stopScratchPlayerBE(_, _) => scratchSoundPlayer.safeStop;

  FutureOr<void> _continueBlocEvent(_, _) =>
      _router..pop(state.sagGameItemAnswer);

  /*
  Events ↑ Methods ↓
   */

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    scratchSoundPlayer.safeStop;
    scratchSoundPlayer?.dispose();
    scratchSoundPlayer.safeStop;
    partyPopperPlayer?.dispose();
    partyPopperPlayer.safeStop;
    crowdCheeringPlayer?.dispose();
    crowdCheeringPlayer.safeStop;
    wrongAnswerPlayer?.dispose();
    return super.close();
  }
}
