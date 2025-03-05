import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticButton extends StatefulWidget {
  final ButtonType buttonType;
  final String? label;
  final PanopticIcons? icon;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final ButtonPosition buttonPosition;
  final bool expanded;
  final bool isDisabled;
  final bool isLoading;
  final double? elevation;
  final bool pride;
  final Color? color;
  final Color? textColor;
  final Widget? badge;
  final Gradient? gradient;
  final bool smaller;

  const PanopticButton({
    super.key,
    this.buttonType = ButtonType.primary,
    this.label,
    this.icon,
    this.trailing,
    this.leading,
    this.onPressed,
    this.onLongPress,
    this.elevation,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.buttonPosition = ButtonPosition.na,
    this.expanded = false,
    this.isDisabled = false,
    this.pride = false,
    this.color,
    this.isLoading = false,
    this.smaller = false,
    this.gradient,
    this.textColor,
    this.badge,
  });

  @override
  State<PanopticButton> createState() => _PanopticButtonState();
}

class _PanopticButtonState extends State<PanopticButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: MaterialButton(
        onPressed:
            widget.isDisabled || widget.isLoading ? null : widget.onPressed,
        onLongPress:
            widget.isDisabled || widget.isLoading ? null : widget.onLongPress,
        disabledColor: _getButtonColor(),
        key: widget.key,
        color: _getButtonColor(),
        textColor: _getTextColor(),
        elevation: widget.elevation,
        padding: EdgeInsets.zero,
        shape: _getShape(),
        child: Container(
          padding: widget.padding,
          decoration: widget.gradient != null
              ? BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius:
                      BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                )
              : null,
          child: widget.isLoading
              ? _buildLoadingIndicator()
              : _buildButtonContent(),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Padding(
          padding: (kIsWeb ||
                      Theme.of(context).platform == TargetPlatform.macOS ||
                      Theme.of(context).platform == TargetPlatform.windows) &&
                  !widget.smaller
              ? const EdgeInsets.all(10)
              : EdgeInsets.zero,
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(_getTextColor()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          PanopticIcon(
            icon: widget.icon!,
            badge: widget.badge,
            color: _getTextColor(),
            size: 20,
            margin: widget.label != null
                ? const EdgeInsets.only(left: 10)
                : (kIsWeb ||
                            Theme.of(context).platform ==
                                TargetPlatform.macOS ||
                            Theme.of(context).platform ==
                                TargetPlatform.windows) &&
                        !widget.smaller
                    ? const EdgeInsets.all(10)
                    : EdgeInsets.zero,
          ),
          if (widget.label != null) const SizedBox(width: 10),
        ] else if (widget.leading != null) ...[
          widget.leading!,
          if (widget.label != null) const SizedBox(width: 10),
        ],
        if (widget.expanded)
          Expanded(
            child: Padding(
              padding: (kIsWeb ||
                          Theme.of(context).platform == TargetPlatform.macOS ||
                          Theme.of(context).platform ==
                              TargetPlatform.windows) &&
                      !widget.smaller
                  ? const EdgeInsets.all(10)
                  : EdgeInsets.zero,
              child: Text(
                widget.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: _getTextColor()),
                textAlign: _getButtonLabelAlignment(),
              ),
            ),
          )
        else if (widget.label != null)
          Padding(
            padding: (kIsWeb ||
                        Theme.of(context).platform == TargetPlatform.macOS ||
                        Theme.of(context).platform == TargetPlatform.windows) &&
                    !widget.smaller
                ? const EdgeInsets.all(10)
                : EdgeInsets.zero,
            child: Text(
              widget.label ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: _getTextColor()),
              textAlign: _getButtonLabelAlignment(),
            ),
          ),
        if (widget.trailing != null) ...[
          if (widget.label != null) const SizedBox(width: 10),
          widget.trailing!,
        ],
      ],
    );
  }

  Color _getButtonColor() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return Theme.of(context).colorScheme.surface;
    }
    switch (widget.buttonType) {
      case ButtonType.primary:
        return widget.color ?? Theme.of(context).colorScheme.primary;
      case ButtonType.secondary:
        return widget.color ?? Theme.of(context).colorScheme.secondary;
      case ButtonType.accent:
        return widget.color ?? Theme.of(context).colorScheme.tertiary;
      case ButtonType.bordered:
      case ButtonType.unselected:
        return Theme.of(context).colorScheme.surface;
    }
  }

  Color _getTextColor() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return Theme.of(context).colorScheme.primary;
    }
    switch (widget.buttonType) {
      case ButtonType.primary:
        return widget.textColor ?? Theme.of(context).colorScheme.onPrimary;
      case ButtonType.secondary:
        return widget.textColor ?? Theme.of(context).colorScheme.onSecondary;
      case ButtonType.accent:
        return widget.textColor ?? Theme.of(context).colorScheme.onTertiary;
      case ButtonType.bordered:
      case ButtonType.unselected:
        return widget.textColor ??
            (widget.color ?? Theme.of(context).colorScheme.primary);
    }
  }

  ShapeBorder _getShape() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      );
    }
    switch (widget.buttonPosition) {
      case ButtonPosition.right:
        return RoundedRectangleBorder(
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(
                  color: widget.color ?? Theme.of(context).colorScheme.primary)
              : BorderSide.none,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(CoreValues.cornerRadius * 0.8),
            topRight: Radius.circular(CoreValues.cornerRadius * 0.8),
          ),
        );
      case ButtonPosition.left:
        return RoundedRectangleBorder(
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(
                  color: widget.color ?? Theme.of(context).colorScheme.primary)
              : BorderSide.none,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
            topLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
          ),
        );
      case ButtonPosition.center:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(
                  color: widget.color ?? Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
      case ButtonPosition.na:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(
                  color: widget.color ?? Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
    }
  }

  TextAlign _getButtonLabelAlignment() {
    if (widget.icon != null && widget.trailing == null) {
      return TextAlign.end;
    }
    if (widget.icon == null && widget.trailing != null) {
      return TextAlign.start;
    }
    return TextAlign.center;
  }
}
