import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/shared/widgets/custom_sliver_connect_something_to.dart';
import 'package:irrigazione_iot/src/utils/extensions.dart';

class SelectAVarietyScreen extends ConsumerStatefulWidget {
  const SelectAVarietyScreen({
    super.key,
    this.selectedVarietyId,
    this.selectedVarietyName,
  });

  final String? selectedVarietyId;
  final String? selectedVarietyName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectAVarietyScreenState();
}

class _SelectAVarietyScreenState extends ConsumerState<SelectAVarietyScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = context.loc;

    return SliverFillRemaining();

    //   return CustomSliverConnectSomethingTo(
    //       title: loc.selectAVarietyPageTitle, child:  SliverFillRemaining());
  }
}
