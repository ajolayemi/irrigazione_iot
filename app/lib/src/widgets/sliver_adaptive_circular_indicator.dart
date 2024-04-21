import 'package:flutter/material.dart';

class SliverAdaptiveCircularIndicator extends StatelessWidget {
  const SliverAdaptiveCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
