import 'package:flutter/material.dart';
import 'more_options_screen_contents.dart';
import '../../../widgets/padded_safe_area.dart';

class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO add sensors section
    // TODO add statistics section
    // TODO fertirrigazione section
    return const Scaffold(
      body: PaddedSafeArea(
        child: MoreOptionsScreenContent(),
      ),
    );
  }
}
