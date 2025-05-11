import 'dart:async';

import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/internet_available_repository.dart';

sealed class GetInternetAvailabilityUseCaseError extends BaseError {}

class GetGamesSettingsStreamUseCaseDataAccessError
    extends GetInternetAvailabilityUseCaseError {}

class GetInternetAvailabilityUseCase {
  final InternetAvailabilityRepository _internetAvailabilityRepository;

  GetInternetAvailabilityUseCase(this._internetAvailabilityRepository);

  Future<Result<bool, GetInternetAvailabilityUseCaseError>> call() async {
    final result =
        await _internetAvailabilityRepository.getInternetAvailability();
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case InternetAvailabilityRepositoryGetInternetAvailabilityDataAccessError():
            return Error(GetGamesSettingsStreamUseCaseDataAccessError());
        }
    }
  }
}
