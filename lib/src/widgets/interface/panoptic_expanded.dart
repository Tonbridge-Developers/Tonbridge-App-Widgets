import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticExpanded extends StatelessWidget {
  const PanopticExpanded(
      {super.key,
      required this.child,
      this.expandOnMobile = true,
      this.expandOnDesktop = true,
      this.flex = 1});
  final Widget child;
  final bool expandOnMobile;
  final bool expandOnDesktop;

  final int flex;

  @override
  Widget build(BuildContext context) {
    return PanopticExtension.getDeviceType(context) == DeviceType.small &&
            expandOnMobile
        ? Expanded(
            flex: flex,
            child: child,
          )
        : PanopticExtension.getDeviceType(context) == DeviceType.large &&
                expandOnDesktop
            ? Expanded(
                flex: flex,
                child: child,
              )
            : child;
  }
}
