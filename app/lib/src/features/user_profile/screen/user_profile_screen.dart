import 'package:flutter/material.dart';
import 'user_profile_screen_content.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/app_sliver_bar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppSliverBar(
              title: loc.profilePageTitle,
            ),
            const UserProfileScreenContents(),
          ],
        ),
      ),
    );
  }
}
