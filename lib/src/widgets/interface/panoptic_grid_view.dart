import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_expanded.dart';

class PanopticGridView extends StatefulWidget {
  const PanopticGridView(
      {super.key,
      this.baseSize = 200,
      required this.children,
      this.padding = const EdgeInsets.all(0),
      this.autoSize = true,
      this.mobileAspectRatio = 2.5,
      this.desktopAspectRatio = 1.5,
      this.physics = const NeverScrollableScrollPhysics(),
      this.columnCount});
  final double baseSize;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final bool autoSize;
  final double mobileAspectRatio;
  final double desktopAspectRatio;
  final int? columnCount;
  final ScrollPhysics physics;

  @override
  State<PanopticGridView> createState() => _PanopticGridViewState();
}

class _PanopticGridViewState extends State<PanopticGridView> {
  @override
  Widget build(BuildContext context) {
    return widget.autoSize
        ? AlignedGridView.count(
            crossAxisCount: widget.columnCount ??
                PanopticExtension.calculateCrossAxisCount(context,
                    baseSize: widget.baseSize),
            itemCount: widget.children.length,
            physics: widget.physics,
            shrinkWrap: true,
            crossAxisSpacing: 0,
            itemBuilder: (BuildContext context, int index) {
              var child = widget.children[index];
              if (child is Expanded) {
                return Expanded(
                  flex: child.flex,
                  child: Container(
                    margin: widget.padding,
                    child: child.child,
                  ),
                );
              } else if (child is PanopticExpanded) {
                return PanopticExpanded(
                  expandOnDesktop: child.expandOnDesktop,
                  expandOnMobile: child.expandOnMobile,
                  flex: child.flex,
                  child: Container(
                    margin: widget.padding,
                    child: child.child,
                  ),
                );
              } else {
                return Container(
                  margin: widget.padding,
                  child: child,
                );
              }
            },
          )
        : GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.columnCount ??
                  PanopticExtension.calculateCrossAxisCount(context,
                      baseSize: widget.baseSize),
              crossAxisSpacing: 0,
              // width / height: fixed for *all* items
              childAspectRatio: PanopticExtension.calculateAspectRatio(context,
                  mobile: widget.mobileAspectRatio,
                  desktop: widget.desktopAspectRatio),
            ),
            physics: widget.physics,
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
              }
            ],
          );
  }
}
