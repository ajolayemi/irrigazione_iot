import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';

class CollectorDetailsScreen extends ConsumerWidget {
  const CollectorDetailsScreen({
    super.key,
    required this.collectorId,
  });

  final CollectorID collectorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
