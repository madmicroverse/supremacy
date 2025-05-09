class BaseError {}

class ConnectionError extends BaseError {}

class Forbidden extends BaseError {}

class NotFound extends BaseError {}

class TimeoutError extends BaseError {}

// class NetworkRequestFailedError extends BaseError {}

class UnknownError extends BaseError {}

class UnexpectedErrorError extends BaseError {
  String error;

  UnexpectedErrorError(this.error);
}

sealed class Result<D, E extends BaseError> {}

class Success<D, E extends BaseError> extends Result<D, E> {
  final D data;

  Success(this.data);
}

class Error<D, E extends BaseError> extends Result<D, E> {
  final E error;

  Error(this.error);
}
