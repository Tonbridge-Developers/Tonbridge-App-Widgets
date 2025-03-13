import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticInputWrapper extends StatelessWidget {
  const PanopticInputWrapper(
      {super.key,
      required this.label,
      required this.child,
      this.hintText,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start});
  final Widget child;
  final String label;
  final String? hintText;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [
            Text(label,
                style: theme.textTheme.labelSmall!.copyWith(color: textColor)),
            if (hintText != null)
              Tooltip(
                message: hintText,
                preferBelow: true,
                triggerMode: PanopticExtension.isWebOrDesktop()
                    ? null
                    : TooltipTriggerMode.tap,
                verticalOffset: 10,
                child: PanopticIcon(
                  icon: PanopticIcons.infoRound,
                  size: 15,
                  margin: const EdgeInsets.only(left: 5, top: 2),
                  color: textColor.withAlpha(100),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
