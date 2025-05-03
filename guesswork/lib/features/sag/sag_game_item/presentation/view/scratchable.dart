import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/features/sag/sag_game_item/presentation/view/bloc_utils.dart';

import '../bloc/sag_game_item_be.dart';
import '../bloc/sag_game_item_bloc.dart';
import '../bloc/sag_game_item_bs.dart';

class ScratchableWidget extends StatelessWidget {
  final SAGGameItemBS sagGameItemBS;
  final double width;
  final double height;
  final double brushRadius;
  final Widget background;
  final Widget foreground;
  final Function(double progress, Set<Offset> revealedPoints) revealedListener;

  const ScratchableWidget({
    super.key,
    required this.sagGameItemBS,
    required this.width,
    required this.height,
    required this.background,
    required this.foreground,
    required this.brushRadius,
    required this.revealedListener,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          context.addEvent(AddPathPointBE(details.localPosition));
        },
        onPanUpdate: (details) {
          context.addEvent(AddPathPointBE(details.localPosition));
        },
        onPanEnd: (details) {
          context.addEvent(AddPathPointBE(details.localPosition));
          context.addEvent(StopScratchPlayerBE());
        },
        child: BlocBuilder<SAGGameItemBloc, SAGGameItemBS>(
          builder: (context, state) {
            if (!state.isRevealedPathAvailable) {
              context.addEvent(InitPathBE(width, height));
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              fit: StackFit.passthrough,
              children: [
                background,
                ClipPath(
                  clipper: HoleClipper(state.revealedPath!),
                  child: foreground,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HoleClipper extends CustomClipper<Path> {
  final Path path;

  const HoleClipper(this.path);

  @override
  Path getClip(Size size) => path;

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
