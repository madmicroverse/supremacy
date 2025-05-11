import 'package:guesswork/core/data/framework/internet_availability_operation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/domain/repository/internet_available_repository.dart';
import 'package:rxdart/rxdart.dart';

class InternetAvailabilityRepositoryImpl
    extends InternetAvailabilityRepository {
  InternetAvailabilityStreamOperation _internetAvailabilityStreamOperation;

  Stream<bool>? _gamesUserStream;
  final _gamesUserBehaviorSubject = BehaviorSubject<bool>();

  InternetAvailabilityRepositoryImpl(this._internetAvailabilityStreamOperation);

  @override
  Future<Result<Stream<bool>, InternetAvailabilityRepositoryStreamError>>
  getInternetAvailabilityStream() async {
    if (_gamesUserStream.isNull) {
      final result = await _internetAvailabilityStreamOperation();
      switch (result) {
        case Success():
          result.data.listen((isInternetAvailable) {
            _gamesUserBehaviorSubject.add(isInternetAvailable);
          });
        case Error():
          final error = result.error;
          switch (error) {
            case InternetAvailabilityStreamOperationDataAccessError():
              return Error(
                InternetAvailabilityRepositoryGetInternetAvailabilityStreamDataAccessError(),
              );
          }
      }
    }
    return Success(_gamesUserBehaviorSubject.stream);
  }

  @override
  Future<Result<bool, InternetAvailabilityRepositoryError>>
  getInternetAvailability() async {
    final result = await getInternetAvailabilityStream();
    switch (result) {
      case Success():
        return Success(await result.data.first);
      case Error():
        final error = result.error;
        switch (error) {
          case InternetAvailabilityRepositoryGetInternetAvailabilityStreamDataAccessError():
            return Error(
              InternetAvailabilityRepositoryGetInternetAvailabilityDataAccessError(),
            );
        }
    }
  }
}
