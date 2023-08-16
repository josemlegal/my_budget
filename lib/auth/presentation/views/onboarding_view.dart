import 'package:flutter/material.dart';
import 'package:my_budget/auth/presentation/controllers/onboarding_view_controller.dart';
import 'package:my_budget/core/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingView extends StatefulHookConsumerWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: _FormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormWidget extends HookConsumerWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.read(onboardingViewProvider).formKey;
    final onboardingViewController = ref.read(onboardingViewProvider);
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                          child: Text(
                        'Nombre y Apellido! 👇',
                        style: textTheme.bodyLarge!.copyWith(
                            color: AppColors.accent,
                            fontStyle: FontStyle.italic),
                      ))
                    ],
                  ),
                ),
              ),
              onChanged: (value) {
                onboardingViewController.updateName(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                onboardingViewController.submitForm();
              },
              child: Text(
                'SUBMIT',
                style: textTheme.titleMedium!.copyWith(
                  color: AppColors.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
