import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_expanded.dart';

class PanopticRow extends StatefulWidget {
  const PanopticRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.textDirection,
  });
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsetsGeometry padding;
  final TextDirection? textDirection;

  @override
  State<PanopticRow> createState() => _PanopticRowState();
}

class _PanopticRowState extends State<PanopticRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      textDirection: widget.textDirection,
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
