import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticLargeButton extends StatefulWidget {
  const PanopticLargeButton(
      {super.key,
      required this.actions,
      this.initialValue,
      required this.onChanged,
      this.alternative = true,
      this.adaptive = false});
  final List<PanopticLargeButtonAction> actions;
  final dynamic initialValue;
  final void Function(dynamic value) onChanged;
  final bool adaptive;
  final bool alternative;

  @override
  State<PanopticLargeButton> createState() => _PanopticLargeButtonState();
}

class _PanopticLargeButtonState extends State<PanopticLargeButton> {
  dynamic _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final columnCount = widget.adaptive
        ? widget.actions.length
        : (PanopticExtension.getDeviceType(context) == DeviceType.small
            ? 1
            : widget.actions.length);

    return PanopticGridView(
      padding: const EdgeInsets.all(5),
      columnCount: columnCount,
      children: widget.actions.map((action) {
        final isSelected = _value == action.value;
        return PanopticCard(
          onPressed: () {
            setState(() {
              _value = action.value;
              widget.onChanged(_value);
            });
          },
          alternative: widget.alternative,
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withAlpha(255)
              : null,
          child: Column(
            children: [
              PanopticIcon(icon: action.icon, size: 70),
              Text(
                action.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (action.subtitle != null)
                Text(
                  action.subtitle!,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              if (action.child != null) action.child!,
            ],
          ),
        );
      }).toList(),
    );
  }
}
