import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';
import 'package:guesswork/core/presentation/extension/animation_utils.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';

import '../bloc/coins_be.dart';
import '../bloc/coins_bloc.dart';
import '../bloc/coins_bsc.dart';

extension ContextBloc on BuildContext {
  CoinsBloc get bloc => read<CoinsBloc>();

  addEvent(CoinsBE coinsBE) => bloc.add(coinsBE);
}

class Coins extends StatelessWidget {
  const Coins({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinsBloc, CoinsBSC>(
      builder: (context, state) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 110,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: kToolbarHeight - 20,
                    child: Image.asset(
                      'assets/images/coins.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Flexible(flex: 1, child: Container()),
                  if (state.amount.isNotNull)
                    AnimatedFlipCounter(
                      value: state.amount!,
                      duration: 3000.ms,
                      wholeDigits: 8,
                      hideLeadingZeroes: true,
                      textStyle: TextStyle(
                        color: context.gamesColors.golden,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ).greyscaleShimmer(state.isLoadingAmount),
          ),
        );
      },
    );
  }
}
