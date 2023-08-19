import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/auth/presentation/controllers/landing_view_controller.dart';
import 'package:my_budget/core/theme/app_theme.dart';

class LandingView extends StatefulHookConsumerWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView> {
  @override
  Widget build(BuildContext context) {
    final landingViewController = ref.read(landingViewProvider);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _LandingViewHeader(),
              const SizedBox(
                height: 50,
              ),
              Text(
                '¡Bienvenido a\nPenguin Meals!',
                style: textTheme.displaySmall!.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              _LandingButton(
                buttonLabel: 'Iniciar sesión con Google',
                onPressed: landingViewController.isLoading
                    ? null
                    : () => landingViewController
                        .signinWithOAuth(SocialSignIn.GoogleSignIn),
                buttonLogo: 'assets/images/google_logo.png',
              ),
              const SizedBox(height: 20),
              Text(
                'powered by <Penguin/Lab>',
                style: textTheme.titleSmall!.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandingViewHeader extends StatelessWidget {
  const _LandingViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 100),
        Center(
            //TODO: Add the correct asset.
            child: FlutterLogo(
          size: 100,
        )),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _LandingButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback? onPressed;
  final String? buttonLogo;

  const _LandingButton({
    required this.buttonLabel,
    required this.onPressed,
    this.buttonLogo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 40,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonLogo != null)
              Image.asset(
                buttonLogo!,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                buttonLabel,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
