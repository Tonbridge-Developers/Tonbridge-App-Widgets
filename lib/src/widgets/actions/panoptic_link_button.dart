import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticLinkButton extends StatefulWidget {
  /// returns true if the link is toggled to active
  final void Function(bool) onToggle;
  final bool initialValue;
  final double width;

  const PanopticLinkButton({
    super.key,
    this.initialValue = true,
    this.width = 48.0,
    required this.onToggle,
  });

  @override
  State<PanopticLinkButton> createState() => _PanopticLinkButtonState();
}

class _PanopticLinkButtonState extends State<PanopticLinkButton> {
  late PanopticIcons icon;
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    icon = getIcon();
  }

  PanopticIcons getIcon() {
    return value ? PanopticIcons.weblink : PanopticIcons.brokenlink;
  }

  void handlePress() {
    setState(() {
      value = !value;
      icon = getIcon();
      widget.onToggle(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: handlePress,
      padding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      icon: PanopticIcon(
        margin: const EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.onSurface,
        icon: icon,
        size: widget.width - 28,
      ),
    );
  }
}
