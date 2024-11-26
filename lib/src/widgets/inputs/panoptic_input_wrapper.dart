import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';

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
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
            if (hintText != null) ...{
              Tooltip(
                message: hintText,
                preferBelow: true,
                triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
                verticalOffset: 10,
                child: PanopticIcon(
                  icon: CoreIcons.infoRound,
                  size: 15,
                  margin: const EdgeInsets.only(left: 5, top: 2),
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                ),
              )
            }
          ],
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}
