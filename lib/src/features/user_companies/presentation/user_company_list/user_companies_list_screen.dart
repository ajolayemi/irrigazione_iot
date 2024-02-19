import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/company_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/data/user_companies_repository.dart';
import 'package:irrigazione_iot/src/features/user_companies/domain/company.dart';
import 'package:irrigazione_iot/src/features/user_companies/presentation/user_company_list/company_logo.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/async_value_widget.dart';

class UserCompaniesListScreen extends ConsumerStatefulWidget {
  const UserCompaniesListScreen({super.key});

  @override
  ConsumerState<UserCompaniesListScreen> createState() =>
      _UserCompaniesListScreenState();
}

class _UserCompaniesListScreenState
    extends ConsumerState<UserCompaniesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.chooseCompany),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final userCompanies = ref.watch(userCompaniesStreamProvider);
            return AsyncValueWidget<List<Company>>(
              value: userCompanies,
              data: (userCompanies) => ListView.builder(
                itemBuilder: (context, index) {
                  final company = userCompanies[index];
                  return InkWell(
                    onTap: () {
                      ref.read(tappedCompanyProvider.notifier).state = company;
                      context.goNamed(AppRoute.home.name);
                    },
                    child: ListTile(
                      leading: CompanyLogo(
                        imageUrl: company.imageUrl,
                      ),
                      title: Text(
                        company.name,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  );
                },
                itemCount: userCompanies.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
