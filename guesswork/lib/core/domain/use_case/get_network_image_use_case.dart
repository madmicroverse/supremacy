import 'dart:async';

import 'package:guesswork/core/domain/entity/image/games_image.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';

sealed class GetNetworkImageError extends BaseError {}

class GetNetworkImageUrlError extends GetNetworkImageError {}

class GetNetworkImageConnectionError extends GetNetworkImageError {}

class GetNetworkImageUseCase {
  final ImageRepository _imageRepository;

  GetNetworkImageUseCase(this._imageRepository);

  Future<Result<GamesImage, GetNetworkImageError>> call(String url) async {
    final result = await _imageRepository.loadImage(url);
    switch (result) {
      case Success():
        return Success(result.data);
      case Error():
        final error = result.error;
        switch (error) {
          case ImageRepositoryLoadImageUrlError():
            return Error(GetNetworkImageUrlError());
          case ImageRepositoryLoadImageConnectionError():
            return Error(GetNetworkImageConnectionError());
        }
    }
  }
}
