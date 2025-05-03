import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/entity/settings/games_settings.dart';
import 'package:guesswork/core/domain/framework/router.dart';
import 'package:guesswork/core/domain/use_case/get_game_settings_use_case.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_spect_ratio_use_case.dart';
import 'package:guesswork/core/domain/use_case/get_network_image_use_case.dart';

import 'sag_game_item_be.dart';
import 'sag_game_item_bs.dart';

class SAGGameItemBloc extends Bloc<SAGGameItemBE, SAGGameItemBS> {
  final IRouter _router;
  final GetNetworkImageUseCase _getNetworkImageUseCase;
  final GetNetworkImageSizeUseCase _getNetworkImageAspectRatioUseCase;
  final GetGamesSettingsUseCase _getGamesSettingsUseCase;

  Set<Offset> concealedPoints = {};
  Set<Offset> pathPoints = {};
  final int _samplingResolution = 200;
  StreamSubscription<GamesSettings>? _gamesSettingsSubscription;

  AudioPlayer? scratchSoundPlayer;
  AudioPlayer? crowdCheeringPlayer;
  AudioPlayer? partyPopperPlayer;
  AudioPlayer? wrongAnswerPlayer;

  SAGGameItemBloc(
    this._router,
    this._getNetworkImageUseCase,
    this._getNetworkImageAspectRatioUseCase,
    this._getGamesSettingsUseCase,
  ) : super(SAGGameItemBS()) {
    on<InitSAGGameItemBE>(_initSAGGameItemBE);
    on<InitGamesImageBE>(_initGamesImageBE);
    on<InitPathBE>(_initPathBE);
    on<AddPathPointBE>(_addPathPointBE);
    on<InitGameSettingsBE>(_initGameSettingsBE);
    on<GamesSettingsUpdateBE>(_gamesSettingsUpdateBE);
    on<LoadImageSAGGameItemBE>(_loadImageScratchAndGuessBlocEvent);
    on<UpdateProgressInfoBE>(_updateProgressInfoBE);
    on<GuessSAGGameItemBE>(_guessBlocEvent);
    on<ContinueSAGGameItemBE>(_continueBlocEvent);
    on<InitAudioPlayersBE>(_initAudioPlayersBE);
    on<StopScratchPlayerBE>(_stopScratchPlayerBE);
    on<PlayPartyPopperSoundBE>(_playPartyPopperSoundBE);
    on<PlayWrongAnswerSoundBE>(_playWrongAnswerSoundBE);
  }

  FutureOr<void> _initSAGGameItemBE(
    InitSAGGameItemBE event,
    Emitter<SAGGameItemBS> emit,
  ) async {
    emit(state.withSagGameItem(event.sagGameItem));
    add(InitAudioPlayersBE());
    add(InitGamesImageBE(event.sagGameItem.guessImageUrl));
    add(InitGameSettingsBE());
  }

  FutureOr<void> _initAudioPlayersBE(
    InitAudioPlayersBE event,
    Emitter<SAGGameItemBS> emit,
  ) async {
    scratchSoundPlayer = AudioPlayer();
    scratchSoundPlayer?.setReleaseMode(ReleaseMode.loop);
    await scratchSoundPlayer?.setSource(AssetSource('sounds/scratching2.mp3'));

    crowdCheeringPlayer = AudioPlayer();
    crowdCheeringPlayer?.setVolume(1);
    crowdCheeringPlayer?.setReleaseMode(ReleaseMode.release);
    await crowdCheeringPlayer?.setSource(
      AssetSource('sounds/audience_cheering_clapping_short.mp3'),
    );

    partyPopperPlayer = AudioPlayer();
    partyPopperPlayer?.setVolume(1);
    partyPopperPlayer?.setReleaseMode(ReleaseMode.release);
    await partyPopperPlayer?.setSource(AssetSource('sounds/party_popper.mp3'));

    wrongAnswerPlayer = AudioPlayer();
    wrongAnswerPlayer?.setVolume(1);
    wrongAnswerPlayer?.setReleaseMode(ReleaseMode.release);
    await wrongAnswerPlayer?.setSource(AssetSource('sounds/wrong_answer.mp3'));
  }

  FutureOr<void> _initGamesImageBE(
    InitGamesImageBE event,
    Emitter<SAGGameItemBS> emit,
  ) async {
    final result = await _getNetworkImageUseCase(event.url);
    switch (result) {
      case Success():
        return emit(state.withGamesImage(result.data));
      case Error():
        throw UnimplementedError();
    }
  }

  FutureOr<void> _initGameSettingsBE(
    InitGameSettingsBE event,
    Emitter<SAGGameItemBS> emit,
  ) async {
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
    print("""
    bloc -> ${runtimeType} ---> ${hashCode}
    """);
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

    emit(state.withRevealedPath(revealedPath));
  }

  FutureOr<void> _addPathPointBE(
    AddPathPointBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    if (scratchSoundPlayer?.state == PlayerState.stopped) {
      scratchSoundPlayer?.resume();
    }

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

    emit(state.withRevealedPath(updatedRevealedPath));
  }

  bool _inCircle(Offset center, Offset point, double radius) {
    final dX = center.dx - point.dx;
    final dY = center.dy - point.dy;
    final h = dX * dX + dY * dY;
    return h <= pow(radius, 2);
  }

  FutureOr<void> _gamesSettingsUpdateBE(
    GamesSettingsUpdateBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    emit(state.withGamesSettings(event.gamesSettings));
  }

  FutureOr<void> _loadImageScratchAndGuessBlocEvent(
    LoadImageSAGGameItemBE event,
    Emitter<SAGGameItemBS> emit,
  ) async {}

  FutureOr<void> _updateProgressInfoBE(
    UpdateProgressInfoBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    // final revealedPoints = state.revealedPoints;
    // emit(state.withProgressInfo(event.revealedPoints, event.revealedRatio));
  }

  FutureOr<void> _guessBlocEvent(
    GuessSAGGameItemBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    final guessGame = state.sagGameItem!;
    final guessGameAnswer = SAGGameItemAnswer(
      guessGameId: guessGame.id,
      guessGameVersion: guessGame.version,
      answerOptionId: event.guess.id,
      isCorrect: guessGame.answer == event.guess.id,
      points: guessGame.points,
    );
    if (guessGameAnswer.isCorrect) {
      add(PlayPartyPopperSoundBE());
      // add(PlayWrongAnswerSoundBE());
    } else {
      wrongAnswerPlayer?.resume();
    }
    emit(state.withSAGGameItemAnswer(guessGameAnswer));
  }

  FutureOr<void> _continueBlocEvent(
    ContinueSAGGameItemBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    _router.pop(state.sagGameItemAnswer);
  }

  @override
  Future<void> close() {
    _gamesSettingsSubscription?.cancel();
    scratchSoundPlayer?.stop();
    scratchSoundPlayer?.dispose();
    partyPopperPlayer?.stop();
    partyPopperPlayer?.dispose();
    crowdCheeringPlayer?.stop();
    crowdCheeringPlayer?.dispose();
    wrongAnswerPlayer?.stop();
    wrongAnswerPlayer?.dispose();
    return super.close();
  }

  FutureOr<void> _stopScratchPlayerBE(
    StopScratchPlayerBE event,
    Emitter<SAGGameItemBS> emit,
  ) {
    if (scratchSoundPlayer?.state == PlayerState.playing) {
      scratchSoundPlayer?.stop();
    }
  }

  FutureOr<void> _playPartyPopperSoundBE(
    PlayPartyPopperSoundBE event,
    Emitter<SAGGameItemBS> emit,
  ) => partyPopperPlayer?.resume();

  FutureOr<void> _playWrongAnswerSoundBE(
    PlayWrongAnswerSoundBE event,
    Emitter<SAGGameItemBS> emit,
  ) => crowdCheeringPlayer?.resume();
}
