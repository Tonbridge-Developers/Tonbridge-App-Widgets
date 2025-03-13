// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_column.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_list_view.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticCardColumn extends StatefulWidget {
  final List<Widget> children;
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final bool? collapsible;
  late bool isCollapsed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
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
  final bool useDarkBorder;
  final Function(bool)? onCollapse;
  final double cornerRadiusFactor;
  final bool hideShadow;

  PanopticCardColumn(
      {super.key,
      required this.children,
      this.label,
      this.leading,
      this.trailing,
      this.collapsible,
      this.margin,
      this.padding,
      this.labelPadding,
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
      this.useDarkBorder = false,
      this.crossAxisAlignment = CrossAxisAlignment.stretch,
      this.cornerRadiusFactor = 1,
      this.hideShadow = false,
      this.onCollapse});

  @override
  State<PanopticCardColumn> createState() => _PanopticCardColumnState();
}

class _PanopticCardColumnState extends State<PanopticCardColumn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.dottedBorder
        ? DottedBorder(
            color: Theme.of(context).colorScheme.primary,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: Radius.circular(
                (CoreValues.cornerRadius * widget.cornerRadiusFactor)),
            child: _buildCard(widget.collapsible == true
                ? buildCollapsibleContent()
                : _buildContent()),
          )
        : _buildCard(widget.collapsible == true
            ? buildCollapsibleContent()
            : _buildContent());
  }

  Widget _buildCard(Widget child) => Container(
        padding: widget.padding ?? const EdgeInsets.all(10),
        width: widget.width,
        height: widget.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: ((widget.useDarkBorder) ||
                  ThemeProvider.controllerOf(context)
                      .currentThemeId
                      .startsWith('white')
              ? Border.all(
                  width: 0.5, color: Theme.of(context).colorScheme.onSurface)
              : null),
          borderRadius: BorderRadius.circular(
              (CoreValues.cornerRadius * widget.cornerRadiusFactor) *
                  (widget.dottedBorder ? 0.9 : 1)),
          gradient: widget.gradient ??
              LinearGradient(
                colors: [
                  widget.color ??
                      (widget.alternative
                          ? Theme.of(context).colorScheme.surfaceContainer
                          : Theme.of(context).colorScheme.surface),
                  widget.color ??
                      (widget.alternative
                          ? Theme.of(context).colorScheme.surfaceContainer
                          : Theme.of(context).colorScheme.surface)
                ],
              ),
        ),
        margin: widget.margin ??
            const EdgeInsetsDirectional.only(top: 10, bottom: 10),
        child: child,
      );

  Widget _buildContent() => SelectionArea(
        child: widget.scrollable
            ? PanopticListView(
                shrinkWrap: true,
                padding: widget.padding ?? const EdgeInsets.all(10),
                children: widget.children,
              )
            : PanopticColumn(
                padding: widget.padding ?? const EdgeInsets.all(10),
                mainAxisAlignment: widget.mainAxisAlignment,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: widget.children,
              ),
      );

  Widget buildCollapsibleContent() => Column(
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MouseRegion(
            cursor: widget.collapsible == true
                ? SystemMouseCursors.click
                : MouseCursor.defer,
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
                    if (widget.label != null)
                      Expanded(
                        child: Text(widget.label!,
                            style: Theme.of(context).textTheme.titleMedium!),
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
          if (widget.isCollapsed == false) _buildContent()
        ],
      );
}
