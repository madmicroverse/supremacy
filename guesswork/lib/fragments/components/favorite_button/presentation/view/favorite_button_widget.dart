import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/fragments/components/favorite_button/presentation/bloc/favorite_button_bsc.dart';

import '../bloc/favorite_button_be.dart';
import '../bloc/favorite_button_bloc.dart';

extension ContextBloc on BuildContext {
  FavoriteButtonBloc get bloc => read<FavoriteButtonBloc>();

  addEvent(FavoriteButtonBE favoriteButtonBE) => bloc.add(favoriteButtonBE);
}

class FavoriteButton extends StatelessWidget {
  final Function() opTap;

  const FavoriteButton({super.key, required this.opTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteButtonBloc, FavoriteButtonBS>(
      builder: (context, state) {
        return IconButton.filled(
          onPressed: state.onPressed,
          icon: Icon(
            state.isFavoriteSafe ? Icons.favorite : Icons.favorite_border,
          ),
        );
        return FilledButton(onPressed: null, child: Text('WTF'));
        return AbsorbPointer(
          absorbing: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: state.isLoadingFavorite ? null : opTap,
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 28,
                    height: 28,
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
                    child: Icon(
                      Icons.favorite,
                      color: context.colorScheme.onPrimary,
                      size: 28 * 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
