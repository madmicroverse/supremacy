import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/fragments/components/favorite_button/presentation/bloc/favorite_button_bsc.dart';

import '../bloc/favorite_button_be.dart';
import '../bloc/favorite_button_bloc.dart';

extension ContextBloc on BuildContext {
  FavoriteButtonBloc get bloc => read<FavoriteButtonBloc>();

  addEvent(FavoriteButtonBE favoriteButtonBE) => bloc.add(favoriteButtonBE);
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

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
      },
    );
  }
}
