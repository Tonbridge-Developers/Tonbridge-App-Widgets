import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticButtonListener extends PanopticButton {
  final String listenKey;
  final PanopticPageBuilderController? controller;

  const PanopticButtonListener({
    super.key,
    required this.listenKey,
    this.controller,
    super.buttonType = ButtonType.primary,
    super.label,
    super.icon,
    super.trailing,
    super.leading,
    super.onPressed,
    super.onLongPress,
    super.elevation,
    super.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    super.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    super.buttonPosition = ButtonPosition.na,
    super.expanded = false,
    super.isDisabled = false,
    super.pride = false,
    super.color,
    super.isLoading = false,
    super.smaller = false,
    super.gradient,
    super.textColor,
    super.badge,
  });

  @override
  State<PanopticButton> createState() => _PanopticButtonListenerState();
}

class _PanopticButtonListenerState extends State<PanopticButtonListener> {
  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller ?? PanopticPageBuilderController.of(context);
    final notifier = ctrl.getLoadingNotifier(widget.listenKey);
    return ListenableBuilder(
      listenable: notifier,
      builder: (ctx, child) {
        return PanopticButton(
          buttonType: widget.buttonType,
          label: widget.label,
          icon: widget.icon,
          trailing: widget.trailing,
          leading: widget.leading,
          onPressed: widget.onPressed,
          onLongPress: widget.onLongPress,
          elevation: widget.elevation,
          padding: widget.padding,
          margin: widget.margin,
          buttonPosition: widget.buttonPosition,
          expanded: widget.expanded,
          isDisabled: widget.isDisabled,
          pride: widget.pride,
          color: widget.color,
          isLoading: notifier.value,
          smaller: widget.smaller,
          gradient: widget.gradient,
          textColor: widget.textColor,
          badge: widget.badge,
        );
      },
    );
  }
}
