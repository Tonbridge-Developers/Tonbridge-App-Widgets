import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_strings.dart';

class PanopticBase64Photo extends StatefulWidget {
  const PanopticBase64Photo(
      {super.key,
      this.base64,
      this.margin = EdgeInsets.zero,
      this.size = 50,
      this.borderRadius = BorderRadius.zero});

  final EdgeInsetsGeometry margin;
  final double size;
  final String? base64;
  final BorderRadiusGeometry borderRadius;

  @override
  State<PanopticBase64Photo> createState() => _PanopticBase64PhotoState();
}

class _PanopticBase64PhotoState extends State<PanopticBase64Photo> {
  bool isLoading = true;
  Image? image;
  @override
  initState() {
    loadImage();
    super.initState();
  }

  Future<void> loadImage() async {
    setState(() {
      isLoading = true;
    });

    if (widget.base64 != null) {
      if (widget.base64 == CoreStrings.defaultPhoto) {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          image = Image.memory(
            base64Decode(widget.base64!),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          );
          isLoading = false;
        });
      }
    }
  }

  Future downloadLargePhoto() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      margin: widget.margin,
      child: GestureDetector(
        onLongPress: downloadLargePhoto,
        child: PanopticLoading(
          loadingType: LoadingType.circular,
          isLoading: isLoading,
          child: ClipRSuperellipse(
            borderRadius: widget.borderRadius,
            clipBehavior: Clip.hardEdge,
            child: image ??
                Image.memory(
                  base64Decode(CoreStrings.defaultPhoto),
                  fit: BoxFit.cover,
                  color: Theme.of(context).colorScheme.primary,
                  colorBlendMode: BlendMode.color,
                  filterQuality: FilterQuality.high,
                ),
          ),
        ),
      ),
    );
  }
}
