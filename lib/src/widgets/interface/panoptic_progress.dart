import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticProgress extends StatelessWidget {
  const PanopticProgress(
      {super.key,
      this.showLabel = true,
      required this.value,
      required this.mapValue,
      this.mapLabel,
      this.color,
      this.mapColor});
  final bool showLabel;
  final dynamic value;
  final double Function(dynamic value) mapValue;
  final String Function(dynamic value)? mapLabel;
  final Color? color;
  final Color Function(dynamic value)? mapColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showLabel)
          Text(mapLabel != null ? mapLabel!(value) : value.toString()),
        const Padding(padding: EdgeInsets.all(2)),
        !showLabel && mapLabel != null
            ? Tooltip(
                message: mapLabel!(value),
                preferBelow: true,
                verticalOffset: 10,
                triggerMode: PanopticExtension.isWebOrDesktop()
                    ? null
                    : TooltipTriggerMode.tap,
                child: _buildProgressBar())
            : _buildProgressBar(),
      ],
    );
  }

  Widget _buildProgressBar() => LinearProgressIndicator(
        value: mapValue(value),
        minHeight: 8,
        borderRadius: BorderRadius.circular(8),
        valueColor: mapColor != null
            ? AlwaysStoppedAnimation<Color>(mapColor!(value))
            : AlwaysStoppedAnimation<Color>(color ?? Colors.green),
        backgroundColor: Colors.grey[300],
      );
}
