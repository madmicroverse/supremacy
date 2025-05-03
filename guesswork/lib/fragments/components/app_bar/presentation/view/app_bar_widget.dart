import 'package:flutter/material.dart';

class GamesAppBarPreferredSize extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget child;

  const GamesAppBarPreferredSize({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  // All this to set Size from view
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class GamesAppBar extends StatelessWidget {
  final Widget coins;
  final Widget settingsButton;
  final Widget noAdsButton;

  const GamesAppBar({
    super.key,
    required this.coins,
    required this.settingsButton,
    required this.noAdsButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(title: coins, actions: [noAdsButton, settingsButton]);
  }
}
