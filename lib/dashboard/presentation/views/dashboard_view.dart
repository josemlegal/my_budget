import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/dashboard/presentation/controllers/dashboard_view_controller.dart';

class DashboardView extends StatefulHookConsumerWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted && ref.read(dashboardViewProvider).currentUser == null) {
        await ref.read(dashboardViewProvider.notifier).getCurrentUser();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewController = ref.watch(dashboardViewProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            homeViewController.currentUser == null
                ? const CircularProgressIndicator()
                : Text(
                    homeViewController.currentUser!.name,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
