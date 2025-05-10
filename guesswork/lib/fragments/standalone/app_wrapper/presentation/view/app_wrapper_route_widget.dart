import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_be.dart';
import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_bloc.dart';
import 'package:guesswork/fragments/standalone/app_wrapper/presentation/bloc/app_wrapper_bs.dart';

const noInternetBannerHeight = 75;

extension ContextBloc on BuildContext {
  AppWrapperBloc get bloc => read<AppWrapperBloc>();

  addEvent(AppWrapperBE event) => bloc.add(event);
}

class AppWrapperRouteWidget extends StatelessWidget {
  final Widget child;

  const AppWrapperRouteWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppWrapperBloc, AppWrapperBS>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              child,
              // if (state.isAppWrapperNoInternetError)
              //   AbsorbPointer(
              //     child: Column(
              //       children: [
              //         Flexible(
              //           flex: 1,
              //           child: Container(
              //             color: context.colorScheme.shadow.withMaxAlpha,
              //           ),
              //         ),
              //         Container(
              //           height: kToolbarHeight,
              //           width: double.maxFinite,
              //           color: context.gamesColors.incorrect,
              //           child: Center(
              //             child: Text(
              //               context.loc.app_wrapper_no_internet_error,
              //               style: context.textTheme.labelLarge?.inverseColor(
              //                 context,
              //               ),
              //             ),
              //           ),
              //         ).shimmer,
              //       ],
              //     ),
              //   ).fadeIn,
            ],
          ),
        );
      },
    );
  }
}
