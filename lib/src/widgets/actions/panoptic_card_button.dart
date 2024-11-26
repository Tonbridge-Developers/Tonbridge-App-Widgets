// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticCardButton extends StatefulWidget {
  final Widget? child;
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final bool? collapsible;
  late bool isCollapsed;
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
  final double? width;
  final double? height;
  final bool scrollable;
  final bool alternative;

  PanopticCardButton(
      {super.key,
      this.child,
      this.label,
      this.leading,
      this.trailing,
      this.collapsible,
      this.margin,
      this.padding,
      this.labelPadding,
      this.onPressed,
      this.onDoublePress,
      this.border,
      this.color,
      this.width,
      this.height,
      this.isCollapsed = false,
      this.scrollable = false,
      this.alternative = false,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.gradient,
      this.crossAxisAlignment = CrossAxisAlignment.stretch});

  @override
  State<PanopticCardButton> createState() => _PanopticCardButtonState();
}

class _PanopticCardButtonState extends State<PanopticCardButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        onDoubleTap: widget.onDoublePress,
        child: Container(
            width: widget.width,
            height: widget.height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                border: widget.border ??
                    (PlatformDispatcher.instance.platformBrightness ==
                                Brightness.dark ||
                            ThemeProvider.controllerOf(context)
                                .currentThemeId
                                .startsWith('white')
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
            margin: widget.margin ??
                const EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: widget.mainAxisAlignment,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (widget.label != null ||
                    widget.leading != null ||
                    widget.trailing != null ||
                    widget.collapsible == true)
                  MouseRegion(
                    cursor: widget.collapsible == true
                        ? SystemMouseCursors.click
                        : MouseCursor.defer,
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
                            if (widget.label != null)
                              Expanded(
                                child: Text(widget.label!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!),
                              ),
                            if (widget.trailing != null) widget.trailing!,
                            if (widget.collapsible == true)
                              widget.isCollapsed
                                  ? const Icon(
                                      Icons.keyboard_arrow_right_rounded)
                                  : const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                if ((widget.isCollapsed == false))
                  widget.scrollable
                      ? Expanded(
                          child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: widget.padding ?? const EdgeInsets.all(10),
                            child: widget.child,
                          ),
                        ))
                      : Padding(
                          padding: widget.padding ?? const EdgeInsets.all(10),
                          child: widget.child,
                        )
              ],
            )),
      ),
    );
  }
}
