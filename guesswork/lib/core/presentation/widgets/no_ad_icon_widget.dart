import 'package:flutter/material.dart';

/// A widget that displays a "No Ads" icon with customizable styling.
/// 
/// This widget creates a circular badge with a crossed-out ad symbol,
/// indicating that the app or a specific feature is ad-free.
class NoAdIconWidget extends StatelessWidget {
  /// The size of the icon widget.
  final double size;
  
  /// The background color of the icon.
  final Color backgroundColor;
  
  /// The color of the icon and text.
  final Color iconColor;
  
  /// Whether to show the text "AD FREE" below the icon.
  final bool showText;
  
  /// Creates a [NoAdIconWidget].
  ///
  /// The [size] parameter defaults to 40.0.
  /// The [backgroundColor] parameter defaults to a semi-transparent black.
  /// The [iconColor] parameter defaults to white.
  /// The [showText] parameter defaults to false.
  const NoAdIconWidget({
    Key? key,
    this.size = 40.0,
    this.backgroundColor = const Color(0xCC000000),
    this.iconColor = Colors.white,
    this.showText = false,
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
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
        
        // Optional "AD FREE" text
        if (showText)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'AD FREE',
              style: TextStyle(
                color: iconColor,
                fontSize: size * 0.25,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
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

  _SlashPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SlashPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
