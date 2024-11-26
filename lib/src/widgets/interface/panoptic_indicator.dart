import 'package:flutter/material.dart';

class PanopticIndicator extends StatefulWidget {
  const PanopticIndicator(
      {super.key, this.color, required this.size, this.margin});

  final Color? color;
  final double size;
  final EdgeInsetsGeometry? margin;

  @override
  State<PanopticIndicator> createState() => _PanopticIndicatorState();
}

class _PanopticIndicatorState extends State<PanopticIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      margin: widget.margin ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.color ?? Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
