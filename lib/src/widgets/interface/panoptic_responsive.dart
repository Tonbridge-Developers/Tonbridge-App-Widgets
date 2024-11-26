import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticResponsive extends StatefulWidget {
  const PanopticResponsive({
    super.key,
    required this.desktopChildren,
    required this.mobileChildren,
  });

  final Widget desktopChildren;
  final Widget mobileChildren;

  @override
  State<PanopticResponsive> createState() => _PanopticResponsiveState();
}

class _PanopticResponsiveState extends State<PanopticResponsive> {
  @override
  Widget build(BuildContext context) {
    return PanopticExtension.getDeviceType(context) == DeviceType.large
        ? widget.desktopChildren
        : widget.mobileChildren;
  }
}
