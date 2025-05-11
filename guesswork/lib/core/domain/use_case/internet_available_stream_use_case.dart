import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/internet_available_repository.dart';

sealed class GetInternetAvailabilityStreamUseCaseError extends BaseError {}

class GetGamesSettingsStreamUseCaseDataAccessError
    extends GetInternetAvailabilityStreamUseCaseError {}

class GetInternetAvailabilityStreamUseCase {
  final InternetAvailabilityRepository _internetAvailabilityRepository;

  GetInternetAvailabilityStreamUseCase(this._internetAvailabilityRepository);

  Future<Result<Stream<bool>, GetInternetAvailabilityStreamUseCaseError>>
  call() async {
    final result =
        await _internetAvailabilityRepository.getInternetAvailabilityStream();
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case InternetAvailabilityRepositoryGetInternetAvailabilityStreamDataAccessError():
            return Error(GetGamesSettingsStreamUseCaseDataAccessError());
        }
    }
  }
}
