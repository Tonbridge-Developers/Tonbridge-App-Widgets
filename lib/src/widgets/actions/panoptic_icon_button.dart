import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticIconButton extends StatefulWidget {
  final VoidCallback? onTap;
  final CoreIcons? icon;
  final Widget? widget;
  final Color? color;
  final Color? foregroundColor;
  final Gradient? gradient;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final Widget? badge;
  final Alignment badgeAlignment;
  final EdgeInsetsGeometry? margin;
  final BorderSide? borderSide;
  final double? elevation;
  final bool isDisabled;
  final bool isLoading;
  final ButtonType buttonType;
  final double size;
  final String? tooltip;
  final TooltipDirection tooltipDirection;

  const PanopticIconButton(
      {super.key,
      this.onTap,
      this.icon,
      this.widget,
      this.color,
      this.foregroundColor,
      this.gradient,
      this.badge,
      this.tooltip,
      this.badgeAlignment = Alignment.topRight,
      this.badgeColor,
      this.badgeTextColor,
      this.borderSide,
      this.buttonType = ButtonType.primary,
      this.tooltipDirection = TooltipDirection.bottom,
      this.elevation,
      this.size = 40,
      this.isLoading = false,
      this.isDisabled = false,
      this.margin});

  @override
  State<PanopticIconButton> createState() => _PanopticIconButtonState();
}

class _PanopticIconButtonState extends State<PanopticIconButton> {
  @override
  Widget build(BuildContext context) {
    assert(widget.icon != null || widget.widget != null,
        "Icon or widget must be provided");

    return widget.badge != null
        ? Badge(
            alignment: widget.badgeAlignment,
            backgroundColor:
                widget.badgeColor ?? Theme.of(context).colorScheme.secondary,
            textColor: widget.badgeTextColor ??
                Theme.of(context).colorScheme.onSecondary,
            label: widget.badge,
            child: widget.tooltip?.isNotEmpty == true
                ? _buildTooltip()
                : _buildButton())
        : widget.tooltip?.isNotEmpty == true
            ? _buildTooltip()
            : _buildButton();
  }

  _buildButton() => Container(
        margin: widget.margin,
        constraints:
            BoxConstraints.tightFor(width: widget.size, height: widget.size),
        child: MaterialButton(
            disabledColor: _getButtonColor(),
            onPressed:
                widget.isDisabled || widget.isLoading ? null : widget.onTap,
            padding: const EdgeInsets.all(0),
            elevation: widget.elevation,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(CoreValues.cornerRadius * 0.8),
              side: widget.borderSide ??
                  (widget.buttonType == ButtonType.bordered
                      ? BorderSide(color: Theme.of(context).colorScheme.primary)
                      : BorderSide.none),
            ),
            color: _getButtonColor(),
            child: Container(
              decoration: widget.gradient != null
                  ? BoxDecoration(
                      gradient: widget.gradient,
                      borderRadius:
                          BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    )
                  : null,
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                        height: widget.size / 2,
                        width: widget.size / 2,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation(_getTextColor()),
                        ),
                      ),
                    )
                  : widget.icon != null
                      ? PanopticIcon(
                          icon: widget.icon!,
                          color: widget.foregroundColor ?? _getTextColor(),
                          size: widget.size / 2,
                        )
                      : widget.widget,
            )),
      );

  _buildTooltip() {
    switch (widget.tooltipDirection) {
      case TooltipDirection.top:
        return Tooltip(
          message: widget.tooltip!,
          textStyle: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? TextStyle(color: Theme.of(context).colorScheme.onSurface)
              : null,
          waitDuration: const Duration(seconds: 3),
          preferBelow: false,
          enableTapToDismiss: true,
          decoration: BoxDecoration(
            color: ThemeProvider.controllerOf(context)
                    .currentThemeId
                    .startsWith('white')
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 2),
          ),
          child: _buildButton(),
        );
      case TooltipDirection.bottom:
        return Tooltip(
          message: widget.tooltip!,
          textStyle: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? TextStyle(color: Theme.of(context).colorScheme.onSurface)
              : null,
          waitDuration: const Duration(seconds: 3),
          preferBelow: true,
          enableTapToDismiss: true,
          decoration: BoxDecoration(
            color: ThemeProvider.controllerOf(context)
                    .currentThemeId
                    .startsWith('white')
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 2),
          ),
          child: _buildButton(),
        );
      case TooltipDirection.left:
        return Tooltip(
          textStyle: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? TextStyle(color: Theme.of(context).colorScheme.onSurface)
              : null,
          message: widget.tooltip!,
          waitDuration: const Duration(seconds: 3),
          preferBelow: false,
          margin: const EdgeInsets.only(right: 50),
          enableTapToDismiss: true,
          verticalOffset: -15,
          decoration: BoxDecoration(
            color: ThemeProvider.controllerOf(context)
                    .currentThemeId
                    .startsWith('white')
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 2),
          ),
          child: _buildButton(),
        );
      case TooltipDirection.right:
        return Tooltip(
          message: widget.tooltip!,
          textStyle: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? TextStyle(color: Theme.of(context).colorScheme.onSurface)
              : null,
          waitDuration: const Duration(seconds: 3),
          preferBelow: false,
          margin: const EdgeInsets.only(left: 50),
          enableTapToDismiss: true,
          verticalOffset: -15,
          decoration: BoxDecoration(
            color: ThemeProvider.controllerOf(context)
                    .currentThemeId
                    .startsWith('white')
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 2),
          ),
          child: _buildButton(),
        );
    }
  }

  _getButtonColor() {
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

  _getTextColor() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return Theme.of(context).colorScheme.primary;
    }
    switch (widget.buttonType) {
      case ButtonType.primary:
        return Theme.of(context).colorScheme.onPrimary;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.onSecondary;
      case ButtonType.accent:
        return Theme.of(context).colorScheme.onTertiary;
      case ButtonType.bordered:
      case ButtonType.unselected:
        return widget.color ?? Theme.of(context).colorScheme.primary;
    }
  }
}
