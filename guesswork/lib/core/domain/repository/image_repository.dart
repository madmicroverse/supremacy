import 'package:guesswork/core/domain/entity/image/games_image.dart';
import 'package:guesswork/core/domain/entity/result.dart';

sealed class ImageRepositoryError extends BaseError {}

class ImageRepositoryLoadImageUrlError extends ImageRepositoryError {}

class ImageRepositoryLoadImageConnectionError extends ImageRepositoryError {}

abstract class ImageRepository {
  Future<Result<GamesImage, ImageRepositoryError>> loadImage(String url);
}
