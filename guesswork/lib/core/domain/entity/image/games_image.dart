import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'games_image.freezed.dart';

@freezed
abstract class GamesImage with _$GamesImage {
  const factory GamesImage({
    required ImageProvider imageProvider,
    required Size size,
    int? points,
  }) = _GamesImage;
}
