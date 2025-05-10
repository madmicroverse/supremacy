import 'dart:async' show Completer;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:guesswork/core/domain/entity/image/games_image.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';

class ImageRepositoryImpl extends ImageRepository {
  @override
  Future<Result<GamesImage, ImageRepositoryError>> loadImage(String url) async {
    final imageProvider = CachedNetworkImageProvider(url);
    final completer = Completer<Result<GamesImage, ImageRepositoryError>>();

    final ImageStream stream = imageProvider.resolve(ImageConfiguration());

    final listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final image = info.image;
        if (!completer.isCompleted) {
          completer.complete(
            Success(
              GamesImage(
                imageProvider: imageProvider,
                size: Size(image.width.toDouble(), image.height.toDouble()),
              ),
            ),
          );
        }
      },
      onError: (exception, stackTrace) {
        switch (exception) {
          case HttpException():
            completer.complete(Error(ImageRepositoryLoadImageUrlError()));
          case SocketException():
            completer.complete(
              Error(ImageRepositoryLoadImageConnectionError()),
            );
        }
      },
    );

    stream.addListener(listener);

    return completer.future.whenComplete(() {
      stream.removeListener(listener);
    });
  }
}
