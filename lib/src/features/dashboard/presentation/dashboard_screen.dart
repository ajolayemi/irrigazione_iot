import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/application/user_companies_service.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/app_sliver_bar.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = ref.watch(currentTappedCompanyProvider).value;
    final nums = List.from(Iterable.generate(50, (i) => i));
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          AppSliverBar(
            title: context.loc.welcome(user?.name ?? ''),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person_3,
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                  onTap: () {
                    context.goNamed(AppRoute.home.name);
                  },
                );
              },
              childCount: nums.length,
            ),
          ),
        ],
      ),
    );
  }
}
