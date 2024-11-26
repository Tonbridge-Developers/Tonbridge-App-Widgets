import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';

class PanopticTab<T> extends StatelessWidget {
  final String? text;
  final CoreIcons? coreIcon;
  final T? value;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry iconMargin;
  final double iconSize;

  const PanopticTab(
      {this.value,
      this.text,
      this.coreIcon,
      this.padding = const EdgeInsets.symmetric(vertical: 13.5),
      this.iconMargin = const EdgeInsets.all(10),
      this.iconSize = 23,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (coreIcon != null)
          PanopticIcon(
            icon: coreIcon!,
            size: iconSize,
            margin: iconMargin,
            color: IconTheme.of(context).color,
          ),
        Padding(
          padding: padding,
          child: Text(
            text ?? value.toString(),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
