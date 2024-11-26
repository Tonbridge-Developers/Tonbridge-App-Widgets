import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_expanded.dart';

class PanopticColumn extends StatefulWidget {
  const PanopticColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final EdgeInsetsGeometry padding;

  @override
  State<PanopticColumn> createState() => _PanopticColumnState();
}

class _PanopticColumnState extends State<PanopticColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
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
