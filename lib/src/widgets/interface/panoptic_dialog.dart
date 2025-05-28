import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticDialog extends StatefulWidget {
  final String title;
  final Widget? child;
  final List<Widget>? actions;
  final bool scrollable;
  final bool isDismissible;

  const PanopticDialog(
      {super.key,
      required this.title,
      this.child,
      this.actions,
      this.scrollable = false,
      this.isDismissible = true});

  @override
  State<PanopticDialog> createState() => _PanopticDialogState();
}

class _PanopticDialogState extends State<PanopticDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
      title: Row(
        children: [
          Text(widget.title),
          const Spacer(),
          if (widget.isDismissible)
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
        ],
      ),
      content: widget.child,
      actions: widget.actions,
      scrollable: widget.scrollable,
      surfaceTintColor: Theme.of(context).dialogBackgroundColor,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
      ),
    );
  }
}
