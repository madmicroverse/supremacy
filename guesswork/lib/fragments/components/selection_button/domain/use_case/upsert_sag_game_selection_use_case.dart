import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/selection_button/domain/repository/games_selection_repository.dart';

sealed class UpsertSAGGameSelectionUseCaseError extends BaseError {}

class UpsertSAGGameSelectionUseCaseDataAccessError
    extends UpsertSAGGameSelectionUseCaseError {}

class UpsertSAGGameSelectionUseCaseUnauthorizedError
    extends UpsertSAGGameSelectionUseCaseError {}

class UpsertSAGGameSelectionUseCase {
  final AccountRepository _accountRepository;
  final SAGGameSelectionRepository _gamesSelectionRepository;
  int? points;

  UpsertSAGGameSelectionUseCase(
    this._accountRepository,
    this._gamesSelectionRepository,
  );

  Future<Result<void, UpsertSAGGameSelectionUseCaseError>> call(
    SAGGame sagGame,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final upsertResult = await _gamesSelectionRepository
            .upsertSAGGameSelection(gamesUser.id, sagGame);
        switch (upsertResult) {
          case Success():
            return Success(upsertResult.data);
          case Error():
            final upsertError = upsertResult.error;
            switch (upsertError) {
              case SAGGameSelectionRepositoryUpsertSAGGameSelectionDataAccessError():
                return Error(UpsertSAGGameSelectionUseCaseDataAccessError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(UpsertSAGGameSelectionUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(UpsertSAGGameSelectionUseCaseDataAccessError());
        }
    }
  }
}
