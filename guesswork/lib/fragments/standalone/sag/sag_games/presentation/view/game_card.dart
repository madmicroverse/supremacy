import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

class GameCard extends StatelessWidget {
  final SAGGame sagGame;
  final Widget favoriteButton;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.sagGame,
    required this.favoriteButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: CachedNetworkImage(
                  imageUrl: sagGame.previewImage,
                  fit: BoxFit.fill,
                  errorWidget: (context, error, stackTrace) {
                    return Center(
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.white54,
                      ),
                    );
                  },
                  progressIndicatorBuilder: (context, child, loadingProgress) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                        value: loadingProgress.progress,
                      ),
                    );
                  },
                ),
              ),
              Align(alignment: Alignment.topRight, child: favoriteButton),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: kToolbarHeight,
                  color: context.colorScheme.surfaceContainerHigh,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sagGame.title,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
