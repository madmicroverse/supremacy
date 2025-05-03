import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';

class GetNetworkImageSizeUseCase {
  final ImageRepository _imageRepository;

  GetNetworkImageSizeUseCase(this._imageRepository);

  Future<Result<Size, BaseError>> call(String url) async {
    final imageProvider = await _imageRepository.loadImage(url);
    // Create a completer to handle the async operation
    final completer = Completer<Result<Size, BaseError>>();

    // Get the image stream
    final ImageStream stream = imageProvider.resolve(ImageConfiguration());

    // Add a listener to get the image info when it's available
    final listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        final image = info.image;
        if (!completer.isCompleted) {
          completer.complete(
            Success(Size(image.width.toDouble(), image.height.toDouble())),
          );
        }
      },
      onError: (exception, stackTrace) {
        completer.complete(Error(UnknownError()));
      },
    );

    // Register the listener
    stream.addListener(listener);

    // Return the future that will complete when the image is loaded
    return completer.future.whenComplete(() {
      stream.removeListener(listener);
    });
  }
}
