// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticInfoCard extends StatefulWidget {
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;

  ///Any Clickable actions that can be performed as part of the info -- typically buttons
  final List<Widget>? actions;
  final EdgeInsetsGeometry margin;
  final EdgeInsets padding;
  final bool isExpanded;
  bool isCollapsed;

  PanopticInfoCard(
      {super.key,
      this.child,
      this.leading,
      this.trailing,
      this.actions,
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.isExpanded = true,
      this.padding = const EdgeInsets.all(10),
      this.isCollapsed = false,
      this.color});

  @override
  State<PanopticInfoCard> createState() => _PanopticInfoCardState();
}

class _PanopticInfoCardState extends State<PanopticInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          border: Border.all(
            color: (widget.color ?? Theme.of(context).colorScheme.primary),
            width: 2,
          ),
          color: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? Theme.of(context).colorScheme.surface
              : (widget.color ?? Theme.of(context).colorScheme.primary)
                  .withAlpha(255),
          borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
        ),
        child: Column(
          children: [
            DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ThemeProvider.controllerOf(context)
                            .currentThemeId
                            .startsWith('white')
                        ? Theme.of(context).colorScheme.primary
                        : (widget.color ??
                            Theme.of(context).colorScheme.primary),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.leading != null) ...{
                    widget.leading!,
                    const SizedBox(width: 10),
                  },
                  if (!widget.isCollapsed) ...{
                    widget.isExpanded
                        ? Expanded(
                            child: widget.child!,
                          )
                        : widget.child!,
                    if (widget.trailing != null) ...{
                      const SizedBox(width: 10),
                      widget.trailing!
                    },
                  } else ...{
                    const Flexible(
                      child: Text('Expand for additional information'),
                    ),
                  },
                  widget.isCollapsed
                      ? IconButton(
                          icon: Icon(Icons.keyboard_arrow_right_rounded,
                              color: (widget.color ??
                                  Theme.of(context).colorScheme.primary)),
                          onPressed: () => setState(() {
                            widget.isCollapsed = !widget.isCollapsed;
                          }),
                        )
                      : IconButton(
                          icon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: (widget.color ??
                                  Theme.of(context).colorScheme.primary)),
                          onPressed: () => setState(() {
                            widget.isCollapsed = !widget.isCollapsed;
                          }),
                        )
                ],
              ),
            ),
            if (widget.actions != null) ...{
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.actions!,
              ),
            }
          ],
        ));
  }
}
