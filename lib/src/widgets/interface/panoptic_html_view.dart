import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticHtmlView extends StatefulWidget {
  final String html;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final double? imageWidth;
  final double? imageHeight;

  const PanopticHtmlView(
      {super.key,
      required this.html,
      this.margin,
      this.textStyle,
      this.imageWidth,
      this.imageHeight});

  @override
  State<PanopticHtmlView> createState() => _PanopticHtmlViewState();
}

class _PanopticHtmlViewState extends State<PanopticHtmlView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(0),
      child: Center(
        child: HtmlWidget(
          widget.html,
          textStyle: widget.textStyle ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          onTapUrl: (url) => PanopticExtension.launch(url),
          imageWidth: widget.imageWidth,
          imageHeight: widget.imageHeight,
        ),
      ),
    );
  }
}
