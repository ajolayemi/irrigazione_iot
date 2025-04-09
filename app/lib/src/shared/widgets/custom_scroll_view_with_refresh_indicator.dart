import 'package:flutter/material.dart';

class CustomScrollViewWithRefreshIndicator extends StatelessWidget {
  const CustomScrollViewWithRefreshIndicator({super.key, required this.onRefresh, required this.slivers});

  final Future<void> Function() onRefresh;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      notificationPredicate: defaultScrollNotificationPredicate,
      child: CustomScrollView(slivers: slivers),
    );
  }
}
