import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:guesswork/core/domain/repository/image_repository.dart';

class ImageRepositoryImpl extends ImageRepository {
  @override
  Future<ImageProvider> loadImage(String url) async {
    return CachedNetworkImageProvider(url);
  }
}
