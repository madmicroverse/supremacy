import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

/// A circular button with a play icon in the center and a circular progress indicator around it.
/// The progress completes based on the provided [duration].
class PlayProgressButton extends StatefulWidget {
  final Widget child;
  final double size;
  final Duration duration;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  const PlayProgressButton({
    Key? key,
    required this.child,
    this.size = 90.0,
    required this.duration,
    this.onPressed,
  }) : super(key: key);

  @override
  State<PlayProgressButton> createState() => _PlayProgressButtonState();
}

class _PlayProgressButtonState extends State<PlayProgressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
        widget.onPressed?.call();
      }
    });
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_isPlaying) {
        _controller.stop();
        _timer?.cancel();
      } else {
        _controller.reset();
        _controller.forward();
      }
      _isPlaying = !_isPlaying;
    });

    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: _togglePlay,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colorScheme.onPrimary,
          ),
          child: Transform.scale(
            scale: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Progress indicator
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _controller.value,
                      backgroundColor: context.colorScheme.onPrimary,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.colorScheme.primary,
                      ),
                      strokeWidth: 10.0,

                      // strokeAlign: 0.5,
                    );
                  },
                ),

                Transform.scale(scale: 0.5, child: widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Example usage:
///
/// ```dart
/// PlayProgressButton(
///   duration: Duration(seconds: 30),
///   onPressed: () {
///     // Handle button press
///   },
///   onComplete: () {
///     // Handle progress completion
///   },
/// )
/// ```
