import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/mvc/panoptic_page_builder_controller.dart';

class PanopticPageBuilderInherited extends InheritedWidget {
  const PanopticPageBuilderInherited({
    super.key,
    required this.controller,
    required super.child,
  });

  final PanopticPageBuilderController controller;

  @override
  bool updateShouldNotify(PanopticPageBuilderInherited oldWidget) {
    return controller != oldWidget.controller;
  }
}
