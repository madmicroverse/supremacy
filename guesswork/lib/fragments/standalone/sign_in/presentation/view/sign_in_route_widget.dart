import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/core/presentation/extension/context_colors.dart';
import 'package:guesswork/core/presentation/extension/localozations.dart';

import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_bloc_events.dart';
import '../bloc/sign_in_bloc_state.dart';

SignInBloc _bloc(BuildContext context) => context.read<SignInBloc>();

class SignInRouteWidget extends StatefulWidget {
  const SignInRouteWidget({super.key});

  @override
  State<SignInRouteWidget> createState() => _SignInRouteWidgetState();
}

class _SignInRouteWidgetState extends State<SignInRouteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInBlocState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: context.gamesColors.incorrect,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  context.colorScheme.primary.withAlpha(230),
                  context.colorScheme.primary.withAlpha(150),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildLogo(context),
                              const SizedBox(height: 60),
                              _buildSignInOptions(state),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) _buildLoadingOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          width: 140,
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.onPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.psychology,
              size: 90,
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          context.loc.app_name,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onPrimary,
            letterSpacing: 3,
            // shadows: [
            //   Shadow(
            //     color: context.colorScheme.onPrimary.withOpacity(0.5),
            //     blurRadius: 7,
            //     offset: const Offset(0, 15),
            //   ),
            // ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            context.loc.app_slogan,
            style: TextStyle(
              fontSize: 16,
              color: context.colorScheme.onPrimary,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInOptions(SignInBlocState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onPrimary.withAlpha(50),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.loc.sign_in_cta,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onPrimary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.loc.sign_in_cta_method,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 30),
          _buildGoogleSignInButton(),
          const SizedBox(height: 16),
          _buildAppleSignInButton(),
          const SizedBox(height: 24),
          _buildDivider(),
          const SizedBox(height: 24),
          _buildPlayAsGuestButton(),
        ],
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: () => _bloc(context).add(GoogleSignInBlocEvent()),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.onPrimary,
        foregroundColor: context.colorScheme.scrim,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/google_sign_in.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 12),
          Text(
            context.loc.sign_in_google_cta,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAppleSignInButton() {
    return ElevatedButton(
      onPressed: () => _bloc(context).add(AppleSignInBlocEvent()),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.scrim,
        foregroundColor: context.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.apple, size: 24),
          const SizedBox(width: 12),
          Text(
            context.loc.sign_in_apple_cta,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(color: context.colorScheme.onPrimary, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            context.loc.sign_in_or,
            style: TextStyle(
              color: context.colorScheme.onPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: context.colorScheme.onPrimary, thickness: 1),
        ),
      ],
    );
  }

  Widget _buildPlayAsGuestButton() {
    return TextButton(
      onPressed: () => _bloc(context).add(AnonymousSignInBlocEvent()),
      style: TextButton.styleFrom(
        foregroundColor: context.colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: context.colorScheme.onPrimary.withAlpha(50)),
        ),
      ),
      child: Text(
        context.loc.sign_in_anonymous_cta,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: context.colorScheme.scrim.withAlpha(100),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary.withAlpha(25),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.scrim.withAlpha(50),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
