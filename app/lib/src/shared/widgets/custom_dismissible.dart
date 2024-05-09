import 'package:flutter/material.dart';

/// A custom dismissible widget that wraps a child widget with a dismissible widget.
/// If [canDelete] is false, the child widget is returned as is.
class CustomDismissibleWidget extends StatelessWidget {
  const CustomDismissibleWidget({
    super.key,
    required this.dismissibleKey,
    required this.isDeleting,
    required this.child,
    this.onDismissed,
    this.confirmDismiss,
    this.canDelete = false,
  });

  final Key dismissibleKey;
  final Widget child;
  final bool isDeleting;
  final bool canDelete;
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;

  @override
  Widget build(BuildContext context) {
    if (!canDelete) return child;
    return Dismissible(
      key: dismissibleKey,
      onDismissed: onDismissed ?? (_) {},
      direction: DismissDirection.endToStart,
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
