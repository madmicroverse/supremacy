import 'package:guesswork/core/domain/entity/result.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

sealed class InternetAvailabilityStreamOperationError extends BaseError {}

class InternetAvailabilityStreamOperationDataAccessError
    extends InternetAvailabilityStreamOperationError {}

class InternetAvailabilityStreamOperation {
  Future<Result<Stream<bool>, InternetAvailabilityStreamOperationError>>
  call() async {
    try {
      return Success(
        InternetConnection().onStatusChange.map((InternetStatus status) {
          switch (status) {
            case InternetStatus.connected:
              return true;
            case InternetStatus.disconnected:
              return false;
          }
        }),
      );
    } catch (error) {
      return Error(InternetAvailabilityStreamOperationDataAccessError());
    }
  }
}
