import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_budget/profile/presentation/controllers/profile_view_controller.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted && ref.read(profileViewProvider).currentUser == null) {
        await ref.read(profileViewProvider.notifier).onInit();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewController = ref.watch(profileViewProvider);

    return Scaffold(
        body: profileViewController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    Text(profileViewController.currentUser!.name),
                  ],
                ),
              ));
  }
}
