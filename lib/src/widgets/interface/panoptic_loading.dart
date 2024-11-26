import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticLoading extends StatelessWidget {
  const PanopticLoading({
    super.key,
    this.child,
    this.isLoading = false,
    required this.loadingType,
    this.circularSize = 20.0,
    this.circularStrokeWidth = 2.0,
    this.useSpacer = false,
    this.future,
    this.onFinish,
    this.animation,
    this.animationFit = BoxFit.fill,
    this.animationWidth = 150,
    this.loadingMessage,
    this.textPadding = const EdgeInsets.symmetric(vertical: 10),
  });

  final Widget? child;
  final bool isLoading;
  final LoadingType loadingType;
  final double circularSize;
  final double circularStrokeWidth;
  final bool useSpacer;
  final Future<dynamic>? future;
  final void Function()? onFinish;
  final String? animation;
  final BoxFit animationFit;
  final double animationWidth;
  final String? loadingMessage;
  final EdgeInsetsGeometry textPadding;

  @override
  Widget build(BuildContext context) {
    Widget childWidget = child ?? Container();
    Widget loadingWidget = useSpacer
        ? Expanded(
            child: Column(
              children: [
                _buildLoadingWidget(loadingType, context),
                const Spacer()
              ],
            ),
          )
        : _buildLoadingWidget(loadingType, context);
    if (!isLoading && future == null) {
      return childWidget;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (loadingMessage != null) ...[
          Padding(
            padding: textPadding,
            child: Text(loadingMessage!,
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ],
        if (future != null)
          FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingWidget;
              }
              onFinish?.call();
              return childWidget;
            },
          )
        else if (isLoading)
          loadingWidget
        else
          childWidget
      ],
    );
  }

  Widget _buildLoadingWidget(LoadingType lType, BuildContext ctx) {
    ThemeData theme = Theme.of(ctx);
    Widget loader;
    switch (lType) {
      case LoadingType.circular:
        loader = Center(
          child: SizedBox(
            height: circularSize,
            width: circularSize,
            child: CircularProgressIndicator(
              strokeWidth: circularStrokeWidth,
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            ),
          ),
        );
        break;
      case LoadingType.linear:
        loader = Container(
          constraints: BoxConstraints.tight(const Size(double.infinity, 5)),
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
            color: theme.colorScheme.primary,
          ),
        );
        break;
      case LoadingType.animated:
        if (animation == null) {
          loader = _buildLoadingWidget(LoadingType.linear, ctx);
        } else {
          loader = Center(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcATop,
              ),
              child: Lottie.asset(
                animation!,
                fit: animationFit,
                width: animationWidth,
              ),
            ),
          );
        }
        break;
    }
    return Container(
        padding: isLoading ? const EdgeInsets.all(10) : EdgeInsets.zero,
        child: loader
        // Add your loading widget code here
        );
  }
}
