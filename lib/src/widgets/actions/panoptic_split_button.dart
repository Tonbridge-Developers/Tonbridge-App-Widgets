import 'package:flutter/material.dart';
import 'package:macos_haptic_feedback/macos_haptic_feedback.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticSplitButton extends StatefulWidget {
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
  final List<PanopticSplitButtonAction> actions;
  final double? width;
  final bool topBar;

  const PanopticSplitButton(
      {super.key,
      this.buttonType = ButtonType.primary,
      this.label,
      this.icon,
      this.trailing,
      this.leading,
      this.onPressed,
      this.onLongPress,
      this.elevation,
      this.width,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      this.buttonPosition = ButtonPosition.na,
      this.expanded = false,
      this.isDisabled = false,
      this.pride = false,
      this.topBar = false,
      this.actions = const [],
      this.isLoading = false});

  @override
  State<PanopticSplitButton> createState() => _PanopticSplitButtonState();
}

class _PanopticSplitButtonState extends State<PanopticSplitButton> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  final _macosHapticFeedback = MacosHapticFeedback();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.margin,
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
              onLongPress: widget.isDisabled || widget.isLoading ? null : widget.onLongPress,
              disabledColor: _getColor('button'),
              key: widget.key,
              color: _getColor('button'),
              textColor: _getColor('text'),
              elevation: widget.elevation,
              padding: widget.padding,
              shape: widget.actions.isEmpty ? _getShape() : _getShape(position: 'left'),
              child: widget.isLoading ? _buildLoadingIndicator() : _buildButtonContent(),
            ),
          ),
          const SizedBox(width: 2),
          if (widget.actions.isNotEmpty) _buildMenuAnchor(),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Padding(
          padding: _getPlatformPadding(),
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(_getColor('text')),
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
        if (widget.icon != null) ...{
          PanopticIcon(
            icon: widget.icon!,
            color: _getColor('text'),
            size: 20,
            margin: const EdgeInsets.only(left: 10),
          ),
          const SizedBox(width: 10),
        } else if (widget.leading != null) ...{
          widget.leading!,
          const SizedBox(width: 10),
        },
        if (widget.expanded)
          Expanded(
            child: Padding(
              padding: _getPlatformPadding(),
              child: Text(
                widget.label ?? "",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: _getColor('text'),
                    ),
                textAlign: _getButtonLabelAlignment(),
              ),
            ),
          )
        else
          Padding(
            padding: _getPlatformPadding(),
            child: Text(
              widget.label ?? "",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: _getColor('text'),
                  ),
              textAlign: _getButtonLabelAlignment(),
            ),
          ),
        if (widget.trailing != null) ...{
          const SizedBox(width: 10),
          widget.trailing!,
        },
      ],
    );
  }

  Widget _buildMenuAnchor() {
    return MenuAnchor(
      style: MenuStyle(
          shape: WidgetStatePropertyAll(RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8)))),
      alignmentOffset: Offset(0, PanopticExtension.isWebOrDesktop() ? 5 : 0),
      childFocusNode: _buttonFocusNode,
      menuChildren: [
        for (var action in widget.actions) ...{
          MenuItemButton(
            leadingIcon: action.icon != null
                ? PanopticIcon(icon: action.icon!, size: 20, color: _getColor('action'))
                : null,
            onPressed: action.onPressed,
            onHover: (value) {
              if (isMacOS) {
                _macosHapticFeedback.generic();
              }
            },
            child: Text(
              action.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: _getColor('action'),
                  ),
            ),
          )
        },
      ],
      builder: (context, controller, child) {
        return SizedBox(
          width: 50,
          child: MaterialButton(
              height: widget.topBar
                  ? (PanopticExtension.isWebOrDesktop() ? 53 : 36)
                  : (PanopticExtension.isWebOrDesktop() ? 57 : 40),
              onPressed: widget.isDisabled
                  ? null
                  : () => controller.isOpen ? controller.close() : controller.open(),
              disabledColor: _getColor('button'),
              color: _getColor('button'),
              textColor: _getColor('text'),
              elevation: widget.elevation,
              shape: _getShape(position: 'right'),
              child: PanopticIcon(
                icon: PanopticIcons.chevrondown,
                size: 20,
                margin: EdgeInsets.zero,
                color: _getColor('text'),
              )),
        );
      },
    );
  }

  Color _getColor(String type) {
    final themeId = ThemeProvider.controllerOf(context).currentThemeId;
    final colorScheme = Theme.of(context).colorScheme;

    if (themeId.startsWith('white')) {
      if (type == 'button') return colorScheme.surface;
      if (type == 'text') return colorScheme.primary;
      if (type == 'action') return colorScheme.primary;
    }

    switch (widget.buttonType) {
      case ButtonType.primary:
        if (type == 'button') return colorScheme.primary;
        if (type == 'text') return colorScheme.onPrimary;
        if (type == 'action') return colorScheme.primary;
        break;
      case ButtonType.secondary:
        if (type == 'button') return colorScheme.secondary;
        if (type == 'text') return colorScheme.onSecondary;
        if (type == 'action') return colorScheme.secondary;
        break;
      case ButtonType.accent:
        if (type == 'button') return colorScheme.tertiary;
        if (type == 'text') return colorScheme.onTertiary;
        if (type == 'action') return colorScheme.tertiary;
        break;
      case ButtonType.bordered:
      case ButtonType.unselected:
        if (type == 'button') return colorScheme.surface;
        if (type == 'text') return colorScheme.primary;
        if (type == 'action') return colorScheme.primary;
        break;
    }
    return Colors.transparent;
  }

  RoundedSuperellipseBorder _getShape({String position = 'center'}) {
    final borderRadius = BorderRadius.circular(CoreValues.cornerRadius * 0.8);
    final side = widget.buttonType == ButtonType.bordered
        ? BorderSide(color: Theme.of(context).colorScheme.primary)
        : BorderSide.none;

    switch (position) {
      case 'left':
        return RoundedSuperellipseBorder(
          borderRadius:
              BorderRadius.only(bottomLeft: borderRadius.bottomLeft, topLeft: borderRadius.topLeft),
          side: side,
        );
      case 'right':
        return RoundedSuperellipseBorder(
          borderRadius: BorderRadius.only(
              bottomRight: borderRadius.bottomRight, topRight: borderRadius.topRight),
          side: side,
        );
      case 'center':
      default:
        return RoundedSuperellipseBorder(
          borderRadius: borderRadius,
          side: side,
        );
    }
  }

  EdgeInsets _getPlatformPadding() {
    return (PanopticExtension.isWebOrDesktop() ||
            Theme.of(context).platform == TargetPlatform.macOS ||
            Theme.of(context).platform == TargetPlatform.windows)
        ? const EdgeInsets.all(10)
        : EdgeInsets.zero;
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
