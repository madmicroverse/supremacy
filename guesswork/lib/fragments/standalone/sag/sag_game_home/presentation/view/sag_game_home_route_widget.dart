import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_home/presentation/bloc/sag_game_home_be.dart';
import 'package:guesswork/fragments/standalone/sag/sag_game_home/presentation/bloc/sag_game_home_bs.dart';

import '../bloc/sag_game_home_bloc.dart';

SagGameHomeBloc _bloc(BuildContext context) => context.read<SagGameHomeBloc>();

extension ContextBloc on BuildContext {
  SagGameHomeBloc get bloc => read<SagGameHomeBloc>();

  addEvent(SagGameHomeBE coinsBE) => bloc.add(coinsBE);
}

class SagGameHomeRouteWidget extends StatelessWidget {
  final Widget child;

  const SagGameHomeRouteWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SagGameHomeBloc, SagGameHomeBS>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.tab.i,
            selectedItemColor: context.colorScheme.primary,
            unselectedItemColor: context.colorScheme.outline,
            onTap:
                (index) => context.addEvent(
                  SelectTabBE(SAGGameHomeTab.fromInt(index)),
                ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.replay),
                label: 'Replay',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
              BottomNavigationBarItem(icon: Icon(Icons.diamond), label: 'Best'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
