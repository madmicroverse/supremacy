import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';
import 'package:guesswork/fragments/components/selection_button/domain/repository/games_selection_repository.dart';

sealed class DeleteSAGGameSelectionUseCaseError extends BaseError {}

class DeleteSAGGameSelectionUseCaseDataAccessError
    extends DeleteSAGGameSelectionUseCaseError {}

class DeleteSAGGameSelectionUseCaseUnauthorizedError
    extends DeleteSAGGameSelectionUseCaseError {}

class DeleteSAGGameSelectionUseCase {
  final AccountRepository _accountRepository;
  final SAGGameSelectionRepository _gamesSelectionRepository;
  int? points;

  DeleteSAGGameSelectionUseCase(
    this._accountRepository,
    this._gamesSelectionRepository,
  );

  Future<Result<void, DeleteSAGGameSelectionUseCaseError>> call(
    String sagGameSelectionId,
  ) async {
    final result = await _accountRepository.getGamesUser();
    switch (result) {
      case Success():
        final gamesUser = result.data;
        final deleteResult = await _gamesSelectionRepository
            .deleteSAGGameSelection(gamesUser.id, sagGameSelectionId);
        switch (deleteResult) {
          case Success():
            return Success(null);
          case Error():
            final deleteError = deleteResult.error;
            switch (deleteError) {
              case SAGGameSelectionRepositoryDeleteSAGGameSelectionDataAccessError():
                return Error(DeleteSAGGameSelectionUseCaseDataAccessError());
            }
        }
      case Error():
        final error = result.error;
        switch (error) {
          case GetGamesUserUnauthorizedError():
            return Error(DeleteSAGGameSelectionUseCaseUnauthorizedError());
          case GetGamesUserDataAccessError():
            return Error(DeleteSAGGameSelectionUseCaseDataAccessError());
        }
    }
  }
}
