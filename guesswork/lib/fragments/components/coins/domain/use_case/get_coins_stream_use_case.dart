import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/account_repository.dart';

class GetCoinsStreamUseCase {
  final AccountRepository _accountRepository;
  int? points;

  GetCoinsStreamUseCase(this._accountRepository);

  Future<Result<Stream<int>, BaseError>> call() async {
    final result = await _accountRepository.getGamesUserStream();
    switch (result) {
      case Success():
        return Success(
          result.data
              .where((gamesUser) {
                final arePointsUpdated = points != gamesUser.progress.points;
                points = gamesUser.progress.points;
                return arePointsUpdated;
              })
              .map((gamesUser) {
                return gamesUser.progress.points;
              }),
        );
      case Error():
        return Error(result.error);
    }
  }
}
