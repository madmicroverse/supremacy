import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/selection_button/domain/repository/games_selection_repository.dart';

sealed class GetSAGGameSelectionsStreamUseCaseError extends BaseError {}

class GetSAGGameSelectionsStreamUseCaseDataAccessError
    extends GetSAGGameSelectionsStreamUseCaseError {}

class GetSAGGameSelectionsStreamUseCaseUnauthorizedError
    extends GetSAGGameSelectionsStreamUseCaseError {}

class GetSAGGameSelectionsStreamUseCase {
  final AccountRepository _accountRepository;
  final SAGGameSelectionRepository _sagGameSelectionRepository;
  int? points;

  GetSAGGameSelectionsStreamUseCase(
    this._accountRepository,
    this._sagGameSelectionRepository,
  );

  Future<Result<Stream<List<SAGGame>>, GetSAGGameSelectionsStreamUseCaseError>>
  call() async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final streamResult = await _sagGameSelectionRepository
            .getSAGGameSelectionsStream(gamesUser.id);
        switch (streamResult) {
          case Success<
            Stream<List<SAGGame>>,
            SAGGameSelectionRepositoryGetSAGGameSelectionsStreamError
          >():
            return Success(streamResult.data);
          case Error():
            final streamError = streamResult.error;
            switch (streamError) {
              case SAGGameSelectionRepositoryGetSAGGameSelectionsStreamDataAccessError():
                return Error(
                  GetSAGGameSelectionsStreamUseCaseDataAccessError(),
                );
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(GetSAGGameSelectionsStreamUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(GetSAGGameSelectionsStreamUseCaseDataAccessError());
        }
    }
  }
}
