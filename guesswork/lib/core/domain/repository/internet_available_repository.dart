import 'package:guesswork/core/domain/entity/result.dart';

sealed class InternetAvailabilityRepositoryStreamError extends BaseError {}

class InternetAvailabilityRepositoryGetInternetAvailabilityStreamDataAccessError
    extends InternetAvailabilityRepositoryStreamError {}

sealed class InternetAvailabilityRepositoryError extends BaseError {}

class InternetAvailabilityRepositoryGetInternetAvailabilityDataAccessError
    extends InternetAvailabilityRepositoryError {}

abstract class InternetAvailabilityRepository {
  Future<Result<Stream<bool>, InternetAvailabilityRepositoryStreamError>>
  getInternetAvailabilityStream();

  Future<Result<bool, InternetAvailabilityRepositoryError>>
  getInternetAvailability();
}
