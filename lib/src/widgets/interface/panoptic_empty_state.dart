import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/actions/panoptic_button.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';

class PanopticEmptyState extends StatefulWidget {
  const PanopticEmptyState(
      {super.key,
      this.width,
      required this.height,
      this.message,
      this.icon,
      this.margin,
      this.action});

  final double? width;
  final double height;
  final String? message;
  final CoreIcons? icon;
  final EdgeInsetsGeometry? margin;
  final PanopticButton? action;

  @override
  State<PanopticEmptyState> createState() => _PanopticEmptyStateState();
}

class _PanopticEmptyStateState extends State<PanopticEmptyState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.margin ?? const EdgeInsets.all(10),
      constraints: BoxConstraints.expand(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height,
      ),
      child: DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(CoreValues.cornerRadius),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PanopticIcon(
                  icon: widget.icon ?? CoreIcons.empty,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  widget.message ?? 'No data available',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                if (widget.action != null) ...{
                  const SizedBox(height: 10),
                  widget.action!
                }
              ],
            ),
          )),

      // Add your widget code here
    );
  }
}
