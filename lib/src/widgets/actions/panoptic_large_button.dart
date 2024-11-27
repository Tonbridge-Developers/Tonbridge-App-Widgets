import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticLargeButton extends StatefulWidget {
  const PanopticLargeButton(
      {super.key,
      required this.actions,
      this.initialValue,
      required this.onChanged,
      this.adaptive = false});
  final List<PanopticLargeButtonAction> actions;
  final dynamic initialValue;
  final void Function(dynamic value) onChanged;
  final bool adaptive;

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
    return PanopticGridView(
      padding: const EdgeInsets.all(5),
      columnCount: widget.adaptive
          ? widget.actions.length
          : (PanopticExtension.getDeviceType(context) == DeviceType.small
              ? 1
              : widget.actions.length),
      children: [
        for (PanopticLargeButtonAction action in widget.actions) ...{
          PanopticCard(
            onPressed: () {
              _value = action.value;
              widget.onChanged(_value);
              setState(() {});
            },
            alternative: true,
            color: _value == action.value
                ? Theme.of(context).colorScheme.primary.withAlpha(55)
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
          ),
        }
      ],
    );
  }
}
