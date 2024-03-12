import 'package:flutter/material.dart';

class CustomDismissibleWidget extends StatelessWidget {
  const CustomDismissibleWidget({
    super.key,
    required this.dismissibleKey,
    required this.isDeleting,
    required this.child,
    this.onDismissed,
    this.confirmDismiss,
  });

  final Key dismissibleKey;
  final Widget child;
  final bool isDeleting;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissibleKey,
      onDismissed: onDismissed ?? (_) {},
      confirmDismiss: confirmDismiss,
      background: Container(
        color: Colors.red,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 20.0),
        child: isDeleting
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(
                Icons.delete,
                color: Colors.white,
              ),
      ),
      child: child,
    );
  }
}
