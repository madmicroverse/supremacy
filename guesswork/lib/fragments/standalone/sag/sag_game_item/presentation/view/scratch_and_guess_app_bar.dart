import 'package:flutter/material.dart';
import 'package:guesswork/core/domain/extension/basic.dart';

import '../bloc/sag_game_item_bs.dart';

class ScratchAndGuessAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final SAGGameItemBS sagGameItemBS;
  final Widget settingsButton;
  final Widget noAdsButton;

  const ScratchAndGuessAppBar({
    super.key,
    required this.sagGameItemBS,
    required this.settingsButton,
    required this.noAdsButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text((sagGameItemBS.sagGameItem?.sagGameTitle).orEmpty),
      centerTitle: true,
      actions: [noAdsButton, settingsButton],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
