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
      await ref.read(dashboardViewProvider.notifier).getTransactions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewController = ref.watch(dashboardViewProvider);
    final isLoading =
        ref.watch(dashboardViewProvider.select((value) => value.isLoading));

    return Scaffold(
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              ref.read(dashboardViewProvider.notifier).addTransaction();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              Navigator.pushNamed(context, '/transaction');
            },
            child: const Icon(Icons.money_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: dashboardViewController.currentUser == null
              ? const CircularProgressIndicator()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dashboardViewController.currentUser!.name,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(dashboardViewProvider.notifier)
                              .getTransactions();
                        },
                        child: const Text('Get Transactions'),
                      ),
                      if (isLoading)
                        const Text('Loading...')
                      else
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: dashboardViewController.listTransactions
                              .map(
                                (transaction) => ListTile(
                                  title: Text(transaction!.title),
                                  subtitle: Text(transaction.amount.toString()),
                                  trailing: Text(
                                    transaction.amount.toString(),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
