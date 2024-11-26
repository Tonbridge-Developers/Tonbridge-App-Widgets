// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/extensions/panoptic_extensions.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_grid_view.dart';

class PanopticFilterCard extends StatefulWidget {
  final List<Widget> children;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final VoidCallback? onPressed;
  final VoidCallback? onDoublePress;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final BoxBorder? border;
  final Color? color;
  final LinearGradient? gradient;
  final bool alternative;
  bool isCollapsed;
  final String label;

  PanopticFilterCard(
      {super.key,
      required this.children,
      this.leading,
      this.trailing,
      this.margin,
      this.padding,
      this.labelPadding,
      this.onPressed,
      this.onDoublePress,
      this.isCollapsed = false,
      this.border,
      this.color,
      this.alternative = false,
      this.label = 'Filters',
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.gradient,
      this.crossAxisAlignment = CrossAxisAlignment.stretch});

  @override
  State<PanopticFilterCard> createState() => _PanopticFilterCardState();
}

class _PanopticFilterCardState extends State<PanopticFilterCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onPressed != null || widget.onDoublePress != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: SelectionArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onPressed,
          onDoubleTap: widget.onDoublePress,
          child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  border: widget.border ??
                      (PlatformDispatcher.instance.platformBrightness ==
                              Brightness.dark
                          ? Border.all(
                              width: 0.5,
                              color: Theme.of(context).colorScheme.onSurface)
                          : null),
                  borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
                  gradient: widget.gradient ??
                      LinearGradient(colors: [
                        widget.color ??
                            (widget.alternative
                                ? Theme.of(context).colorScheme.surfaceContainer
                                : Theme.of(context).colorScheme.surface),
                        widget.color ??
                            (widget.alternative
                                ? Theme.of(context).colorScheme.surfaceContainer
                                : Theme.of(context).colorScheme.surface)
                      ])),
              margin: widget.margin ?? EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: widget.mainAxisAlignment,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() {
                        widget.isCollapsed = !widget.isCollapsed;
                      }),
                      child: Padding(
                        padding: widget.labelPadding ??
                            const EdgeInsetsDirectional.only(
                                top: 10, bottom: 10, start: 10, end: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            if (widget.leading != null) ...{
                              widget.leading!,
                              const SizedBox(width: 10),
                            },
                            Expanded(
                              child: Text(widget.label,
                                  style:
                                      Theme.of(context).textTheme.titleMedium!),
                            ),
                            if (widget.trailing != null) widget.trailing!,
                            widget.isCollapsed
                                ? const Icon(Icons.keyboard_arrow_right_rounded)
                                : const Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if ((widget.isCollapsed == false))
                    PanopticGridView(
                      autoSize: true,
                      columnCount: PanopticExtension.calculateCrossAxisCount(
                              context,
                              baseSize: 350)
                          .roundToNearestEvenOrOne(),
                      padding: widget.padding ?? const EdgeInsets.all(10),
                      children: [
                        for (var child in widget.children) ...{
                          child,
                        }
                      ],
                    )
                ],
              )),
        ),
      ),
    );
  }
}
