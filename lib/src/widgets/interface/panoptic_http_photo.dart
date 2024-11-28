import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticHttpPhoto extends StatefulWidget {
  const PanopticHttpPhoto(
      {super.key,
      this.link,
      this.margin = EdgeInsets.zero,
      this.size = 50,
      this.borderRadius = BorderRadius.zero,
      this.errorIcon = const PanopticIcon(icon: PanopticIcons.person, size: 50),
      this.width,
      this.height,
      this.forceHttps = true});

  final EdgeInsetsGeometry margin;
  final double size;
  final String? link;
  final BorderRadiusGeometry borderRadius;
  final PanopticIcon errorIcon;
  final bool forceHttps;
  final double? width;
  final double? height;

  @override
  State<PanopticHttpPhoto> createState() => _PanopticHttpPhotoState();
}

class _PanopticHttpPhotoState extends State<PanopticHttpPhoto> {
  late double width;
  late double height;

  @override
  initState() {
    super.initState();

    if (widget.width == null) {
      width = widget.size;
    } else {
      width = widget.width!;
    }
    if (widget.height == null) {
      height = widget.size;
    } else {
      height = widget.height!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        clipBehavior: Clip.hardEdge,
        child: ImageNetwork(
          key: widget.key,
          image: widget.forceHttps
              ? widget.link?.replaceAll('http://', "https://") ?? ''
              : widget.link ?? '',
          height: width,
          width: height,
          fitAndroidIos: BoxFit.cover,
          fitWeb: BoxFitWeb.cover,
          curve: Curves.linear,
          duration: 0, // this is for animation in milliseconds i believe
          onLoading: Center(
            child: SizedBox(
              height: height / 2,
              width: width / 2,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          onError: widget.errorIcon,
        ),
      ),
    );
  }
}
