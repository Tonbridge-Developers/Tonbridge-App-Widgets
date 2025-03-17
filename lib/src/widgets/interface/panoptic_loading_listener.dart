import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticLoadingListener extends StatelessWidget {
  const PanopticLoadingListener({
    super.key,
    required this.listenKey,
    this.controller,
    this.loadingType,
    this.circularSize = 20.0,
    this.circularStrokeWidth = 2.0,
    this.useSpacer = false,
    this.animation,
    this.animationFit = BoxFit.fill,
    this.animationWidth = 150,
    this.loadingMessage,
    this.textPadding = const EdgeInsets.symmetric(vertical: 10),
    this.child,
  });

  final String listenKey;
  final Widget? child;
  final LoadingType? loadingType;
  final double circularSize;
  final double circularStrokeWidth;
  final bool useSpacer;
  final String? animation;
  final BoxFit animationFit;
  final double animationWidth;
  final String? loadingMessage;
  final EdgeInsetsGeometry textPadding;
  final PanopticPageBuilderController? controller;

  @override
  Widget build(BuildContext context) {
    final ctrl = controller ?? PanopticPageBuilderController.of(context);
    final notifier = ctrl.getLoadingNotifier(listenKey);
    return ListenableBuilder(
        listenable: notifier,
        child: child,
        builder: (ctx, ch) {
          return PanopticLoading(
              loadingType: loadingType ?? LoadingType.fromContext(context),
              circularSize: circularSize,
              circularStrokeWidth: circularStrokeWidth,
              useSpacer: useSpacer,
              animation: animation,
              animationFit: animationFit,
              animationWidth: animationWidth,
              loadingMessage: loadingMessage,
              textPadding: textPadding,
              isLoading: notifier.value,
              child: ch);
        });
  }
}
