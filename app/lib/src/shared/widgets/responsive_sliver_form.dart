import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_scrollable.dart';

class ResponsiveSliverForm extends StatelessWidget {
  const ResponsiveSliverForm({
    super.key,
    required this.node,
    required this.formKey,
    required this.children,
  });

  final List<Widget> children;
  final FocusScopeNode node;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveScrollable(
        child: FocusScope(
          node: node,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
