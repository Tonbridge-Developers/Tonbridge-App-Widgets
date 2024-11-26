import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_loading.dart';

class PanopticPageContent extends StatefulWidget {
  const PanopticPageContent({
    super.key,
    required this.controller,
    required this.loadingType,
    required this.child,
    this.animation,
    this.loadingMessage,
  });

  final PanopticPageController controller;
  final LoadingType loadingType;
  final Widget child;
  final String? animation;
  final String? loadingMessage;

  @override
  State<PanopticPageContent> createState() => _PanopticPageContent();
}

class _PanopticPageContent extends State<PanopticPageContent> {
  @override
  void initState() {
    super.initState();

    widget.controller.addViewState(this);
  }

  @override
  Widget build(BuildContext context) {
    return PanopticLoading(
      loadingType: widget.loadingType,
      useSpacer: true,
      future: widget.controller.future,
      animation: widget.animation,
      loadingMessage: widget.loadingMessage,
      child: widget.child,
    );
  }
}
