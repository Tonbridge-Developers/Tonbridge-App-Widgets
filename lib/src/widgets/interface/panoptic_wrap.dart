import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_expanded.dart';

class PanopticWrap extends StatefulWidget {
  const PanopticWrap({
    super.key,
    required this.children,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.center,
    this.direction = Axis.horizontal,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });
  final List<Widget> children;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final Axis direction;
  final EdgeInsetsGeometry padding;

  @override
  State<PanopticWrap> createState() => _PanopticWrapState();
}

class _PanopticWrapState extends State<PanopticWrap> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: widget.crossAxisAlignment,
      alignment: widget.alignment,
      direction: widget.direction,
      children: [
        for (var child in widget.children) ...{
          if (child is Expanded) ...{
            Expanded(
              flex: child.flex,
              child: Container(
                margin: widget.padding,
                child: child.child,
              ),
            ),
          } else if (child is PanopticExpanded) ...{
            PanopticExpanded(
              expandOnDesktop: child.expandOnDesktop,
              expandOnMobile: child.expandOnMobile,
              flex: child.flex,
              child: Container(
                margin: widget.padding,
                child: child.child,
              ),
            ),
          } else ...{
            Container(
              margin: widget.padding,
              child: child,
            ),
          }
        },
      ],
    );
  }
}
