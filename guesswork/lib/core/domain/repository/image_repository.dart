import 'package:flutter/cupertino.dart';

abstract class ImageRepository {
  Future<ImageProvider> loadImage(String url);
}
