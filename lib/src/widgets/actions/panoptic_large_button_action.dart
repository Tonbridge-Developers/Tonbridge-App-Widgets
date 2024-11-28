import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticLargeButtonAction {
  final Key? key;
  final String title;
  final dynamic value;
  final PanopticIcons icon;
  final Widget? child;
  final String? subtitle;

  PanopticLargeButtonAction({
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.child,
    this.key,
  });
}
