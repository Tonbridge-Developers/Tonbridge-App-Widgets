import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

class PanopticFormFieldView extends StatefulWidget {
  const PanopticFormFieldView(
      {super.key,
      required this.value,
      required this.label,
      this.slideOver = false,
      this.multiLine = false,
      this.forceColumn = false});
  final dynamic value;
  final String label;
  final bool slideOver;
  final bool multiLine;
  final bool forceColumn;

  @override
  State<PanopticFormFieldView> createState() => _PanopticFormFieldViewState();
}

class _PanopticFormFieldViewState extends State<PanopticFormFieldView> {
  @override
  Widget build(BuildContext context) {
    return widget.multiLine ? _buildMultiLineView() : _buildResponsiveView();
  }

  Widget _buildResponsiveView() => PanopticResponsiveLayout(
        childrenPadding: const EdgeInsets.all(2),
        forceColumn: widget.forceColumn,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLabel(),
          const Padding(padding: EdgeInsets.all(5)),
          _buildValueContainer(),
        ],
      );

  Widget _buildMultiLineView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel(),
          const Padding(padding: EdgeInsets.all(5)),
          _buildValueContainer(),
        ],
      );

  Widget _buildLabel() => Text(
        widget.label,
        style: Theme.of(context).textTheme.bodyLarge,
      );

  Widget _buildValueContainer() => Container(
        padding: const EdgeInsets.all(17),
        constraints: widget.slideOver
            ? null
            : BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
        width: widget.forceColumn || widget.slideOver ? null : 400,
        child: Text(
          widget.value.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
}
