import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/features/more/screen/more_options_screen_contents.dart';
import 'package:irrigazione_iot/src/widgets/padded_safe_area.dart';

class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PaddedSafeArea(
        child: MoreOptionsScreenContent(),
      ),
    );
  }
}
