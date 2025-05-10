import 'package:flutter/material.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

class NoAdIconWidget extends StatelessWidget {
  final double size;

  final Color iconColor;

  const NoAdIconWidget({
    Key? key,
    this.size = 40.0,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: context.gamesColors.correct,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.scrim,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ad text
              Text(
                'AD',
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.4,
                ),
              ),

              // Diagonal line (slash)
              CustomPaint(
                size: Size(size * 0.8, size * 0.8),
                painter: _SlashPainter(
                  color: iconColor,
                  strokeWidth: size * 0.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom painter that draws a diagonal line (slash) for the "no ad" symbol.
class _SlashPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _SlashPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SlashPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
