import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

part 'sag_games_bsc.freezed.dart';

@freezed
abstract class SAGGamesBSC with _$SAGGamesBSC {
  const factory SAGGamesBSC({List<SAGGamePreview>? sagGamePreviewList}) =
      _SAGGamesBSC;
}
