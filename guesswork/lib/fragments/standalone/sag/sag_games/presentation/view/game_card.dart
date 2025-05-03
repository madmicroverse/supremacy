import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';

/// A card widget that displays a game preview with image and title below.
class GameCard extends StatelessWidget {
  /// The game preview data to display.
  final SAGGamePreview gamePreview;

  final VoidCallback onTap;

  const GameCard({super.key, required this.gamePreview, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: Colors.blueGrey.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                gamePreview.previewImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.white54,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[900],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white70,
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  gamePreview.title,
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
          ],
        ),
      ),
    );
  }
}
