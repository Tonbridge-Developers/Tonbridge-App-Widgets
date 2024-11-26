import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticIcon extends StatelessWidget {
  const PanopticIcon({
    super.key,
    required this.icon,
    required this.size,
    this.color,
    this.margin = const EdgeInsets.all(10),
    this.pride = false,
    this.bw = false,
    this.badge,
    this.badgeOffset = const Offset(10, -10),
  });

  final CoreIcons icon;
  final double size;
  final Color? color;
  final bool bw;
  final EdgeInsetsGeometry margin;
  final bool pride;
  final Widget? badge;
  final Offset? badgeOffset;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: margin,
      child: Badge(
        offset: badgeOffset,
        label: badge,
        isLabelVisible: badge != null,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: pride
            ? ShaderMask(
                shaderCallback: (bounds) {
                  return SweepGradient(
                    colors: Themes.pride,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: SvgPicture.asset(
                  icon.path!,
                  colorFilter: ColorFilter.mode(
                      bw
                          ? theme.colorScheme.onSurface
                          : (color ?? theme.colorScheme.primary),
                      BlendMode.srcIn),
                  width: size,
                  height: size,
                ),
              )
            : SvgPicture.asset(
                icon.path!,
                colorFilter: ColorFilter.mode(
                    bw
                        ? theme.colorScheme.onSurface
                        : (color ?? theme.colorScheme.primary),
                    BlendMode.srcIn),
                width: size,
                height: size,
              ),
      ),
    );
  }
}
