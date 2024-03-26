import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:irrigazione_iot/src/config/routes/app_router.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/features/authentication/data/auth_repository.dart';
import 'package:irrigazione_iot/src/features/company_users/model/company_user.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';
import 'package:irrigazione_iot/src/widgets/responsive_center.dart';

class CompanyUserListTile extends StatelessWidget {
  const CompanyUserListTile({
    super.key,
    required this.user,
  });

  final CompanyUser user;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final loc = context.loc;
    // TODO: replace with proper state management
    const shouldIgnore = false;
    return IgnorePointer(
      ignoring: shouldIgnore,
      child: ResponsiveCenter(
        padding: const EdgeInsets.only(
          left: Sizes.p8,
        ),
        child: InkWell(
            onTap: () => context.pushNamed(
                  AppRoute.companyUserDetails.name,
                  pathParameters: {
                    'companyUserId': user.id.toString(),
                  },
                ),
            child: Consumer(
              builder: (context, ref, child) {
                final currentLoggedInUser =
                    ref.watch(authRepositoryProvider).currentUser;
                final isMe = currentLoggedInUser != null &&
                    currentLoggedInUser.email == user.email;
                return ListTile(
                  title: Text(isMe ? loc.me : user.fullName),
                  subtitle: Text(
                    user.email,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            )),
      ),
    );
  }
}
