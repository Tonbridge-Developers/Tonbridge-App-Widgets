// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:macos_haptic_feedback/macos_haptic_feedback.dart';
import 'package:os_detect/os_detect.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticCard extends StatefulWidget {
  final Widget child;
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final bool? collapsible;
  late bool isCollapsed;
  final String? collapsedLabel;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onDoublePress;
  final Function(TapDownDetails)? onTapDown;
  final Function(TapDownDetails)? onSecondaryTapDown;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final BoxBorder? border;
  final Color? color;
  final LinearGradient? gradient;
  final double? width;
  final double? height;
  final bool scrollable;
  final bool alternative;
  final bool dottedBorder;
  final Function(bool)? onCollapse;
  final bool useDarkBorder;
  final double cornerRadiusFactor;
  final bool hideShadow;

  /// If true, the card will be rendered as a basic card without any additional features.
  final bool basicCard;

  PanopticCard({
    super.key,
    required this.child,
    this.label,
    this.leading,
    this.trailing,
    this.collapsible,
    this.collapsedLabel,
    this.margin,
    this.padding,
    this.labelPadding,
    this.onPressed,
    this.onLongPress,
    this.onDoublePress,
    this.onSecondaryPressed,
    this.onTapDown,
    this.onSecondaryTapDown,
    this.border,
    this.color,
    this.width,
    this.height,
    this.isCollapsed = false,
    this.scrollable = false,
    this.alternative = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.gradient,
    this.dottedBorder = false,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.useDarkBorder = false,
    this.cornerRadiusFactor = 1.0,
    this.hideShadow = false,
    this.onCollapse,
    this.basicCard = false,
  });

  @override
  State<PanopticCard> createState() => _PanopticCardState();
}

class _PanopticCardState extends State<PanopticCard> {
  final _macosHapticFeedback = MacosHapticFeedback();
  final focusNode = FocusNode(
    skipTraversal: true,
    canRequestFocus: false,
  );
  final focusNode2 = FocusNode(
    skipTraversal: true,
    canRequestFocus: false,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.basicCard
        ? _buildCard(_basicContent())
        : widget.dottedBorder
            ? DottedBorder(
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: Radius.circular((CoreValues.cornerRadius * widget.cornerRadiusFactor)),
                child: _buildCard(
                    widget.collapsible == true ? buildCollapsibleContent() : _buildContent()),
              )
            : _buildCard(widget.collapsible == true ? buildCollapsibleContent() : _buildContent());
  }

  Widget _buildCard(Widget child) => Material(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(
              (CoreValues.cornerRadius * widget.cornerRadiusFactor) *
                  (widget.dottedBorder ? 0.9 : 1)),
          side: widget.border != null
              ? BorderSide(
                  color: (widget.border as Border?)?.top.color ?? Colors.transparent,
                  width: (widget.border as Border?)?.top.width ?? 0.5,
                )
              : BorderSide(
                  color: widget.useDarkBorder
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.transparent,
                  width: 0.5,
                ),
        ),
        color: widget.color ??
            (widget.alternative
                ? Theme.of(context).colorScheme.surfaceContainer
                : Theme.of(context).colorScheme.surface),
        child: ClipRSuperellipse(
          child: Container(
            padding: widget.padding ?? const EdgeInsets.all(10),
            width: widget.width,
            height: widget.height,
            margin: widget.margin ?? const EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: child,
          ),
        ),
      );

  Widget _basicContent() => InkWell(
        focusNode: focusNode2,
        onDoubleTap: widget.onDoublePress,
        onHover: (value) {
          if (widget.onPressed != null || widget.onDoublePress != null) {
            if (isMacOS) {
              _macosHapticFeedback.generic();
            }
          }
        },
        onTap: widget.onPressed,
        onLongPress: widget.onLongPress,
        onTapDown: widget.onTapDown,
        onSecondaryTap: widget.onSecondaryPressed,
        onSecondaryTapDown: widget.onSecondaryTapDown,
        child: widget.child,
      );

  Widget _buildContent() => SelectionArea(
        focusNode: focusNode,
        child: InkWell(
          focusNode: focusNode2,
          onDoubleTap: widget.onDoublePress,
          onHover: (value) {
            if (widget.onPressed != null || widget.onDoublePress != null) {
              if (isMacOS) {
                _macosHapticFeedback.generic();
              }
            }
          },
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          onTapDown: widget.onTapDown,
          onSecondaryTap: widget.onSecondaryPressed,
          onSecondaryTapDown: widget.onSecondaryTapDown,
          child: widget.scrollable
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: widget.padding ?? const EdgeInsets.all(10),
                    child: widget.child,
                  ),
                )
              : Center(
                  child: widget.child,
                ),
        ),
      );

  Widget buildCollapsibleContent() => Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MouseRegion(
            cursor: widget.collapsible == true ? SystemMouseCursors.click : MouseCursor.defer,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() {
                widget.isCollapsed = !widget.isCollapsed;
                if (widget.onCollapse != null) {
                  widget.onCollapse!(widget.isCollapsed);
                }
              }),
              child: Padding(
                padding: widget.labelPadding ??
                    (!widget.isCollapsed
                        ? const EdgeInsetsDirectional.only(bottom: 10)
                        : const EdgeInsets.all(0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (widget.leading != null) ...{
                      widget.leading!,
                      const SizedBox(width: 10),
                    },
                    if (widget.label != null) ...{
                      if (widget.isCollapsed && widget.collapsedLabel != null) ...{
                        Expanded(
                          child: Text(widget.collapsedLabel!,
                              style: Theme.of(context).textTheme.titleMedium!),
                        ),
                      } else ...{
                        Expanded(
                          child:
                              Text(widget.label!, style: Theme.of(context).textTheme.titleMedium!),
                        ),
                      }
                    },
                    if (widget.trailing != null) widget.trailing!,
                    widget.isCollapsed
                        ? const Icon(Icons.keyboard_arrow_right_rounded)
                        : const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
          ),
          if (widget.isCollapsed == false)
            SelectionArea(
              child: InkWell(
                onDoubleTap: widget.onDoublePress,
                onTap: widget.onPressed,
                onLongPress: widget.onLongPress,
                onTapDown: widget.onTapDown,
                onSecondaryTap: widget.onSecondaryPressed,
                onSecondaryTapDown: widget.onSecondaryTapDown,
                child: widget.scrollable
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: widget.padding ?? const EdgeInsets.all(10),
                          child: widget.child,
                        ),
                      )
                    : widget.child,
              ),
            ),
        ],
      );
}
