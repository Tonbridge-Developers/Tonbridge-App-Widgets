import 'dart:ui';

import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticSplitButtonAction {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final CoreIcons? icon;
  final String label;
  final bool isDisabled;

  PanopticSplitButtonAction(
      {required this.onPressed,
      this.onLongPress,
      this.icon,
      required this.label,
      this.isDisabled = false});
}
