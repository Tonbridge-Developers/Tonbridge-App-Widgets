import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_expanded.dart';

class PanopticListView extends StatefulWidget {
  const PanopticListView({
    super.key,
    required this.children,
    this.shrinkWrap = true,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });
  final List<Widget> children;
  final bool shrinkWrap;

  final EdgeInsetsGeometry padding;

  @override
  State<PanopticListView> createState() => _PanopticListViewState();
}

class _PanopticListViewState extends State<PanopticListView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: widget.shrinkWrap,
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
