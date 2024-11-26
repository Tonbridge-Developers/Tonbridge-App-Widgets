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
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          if (widget.slideOver) ...{
            Container(
              padding: const EdgeInsets.all(17),
              child: Text(
                widget.value.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          } else ...{
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              padding: const EdgeInsets.all(17),
              width: widget.forceColumn ? null : 400,
              child: Text(
                widget.value.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          }
        ],
      );

  Widget _buildMultiLineView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Container(
            padding: const EdgeInsets.all(17),
            child: Text(
              widget.value.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
}
