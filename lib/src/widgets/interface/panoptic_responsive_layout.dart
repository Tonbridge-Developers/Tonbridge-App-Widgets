import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticResponsiveLayout extends StatefulWidget {
  const PanopticResponsiveLayout({
    super.key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.columnMainAxisAlignment,
    this.columnCrossAxisAlignment,
    this.rowMainAxisAlignment,
    this.rowCrossAxisAlignment,
    this.childrenPadding,
    this.forceColumn = false,
    this.forceRow = false,
  });

  final List<Widget> children;
  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final MainAxisAlignment? rowMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool forceColumn;
  final bool forceRow;

  @override
  State<PanopticResponsiveLayout> createState() =>
      _PanopticResponsiveLayoutState();
}

class _PanopticResponsiveLayoutState extends State<PanopticResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    if (widget.forceColumn) {
      return _buildColumn();
    } else if (widget.forceRow) {
      return _buildRow();
    } else if (PanopticExtension.getDeviceType(context) == DeviceType.large) {
      return _buildRow();
    } else {
      return _buildColumn();
    }
  }

  Widget _buildRow() => PanopticRow(
        mainAxisAlignment:
            widget.rowMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            widget.rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: widget.mainAxisSize,
        padding: widget.childrenPadding ??
            const EdgeInsets.symmetric(horizontal: 10),
        children: widget.children,
      );

  Widget _buildColumn() => PanopticColumn(
        mainAxisAlignment:
            widget.columnMainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment:
            widget.columnCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: widget.mainAxisSize,
        padding:
            widget.childrenPadding ?? const EdgeInsets.symmetric(vertical: 10),
        children: widget.children,
      );
}
