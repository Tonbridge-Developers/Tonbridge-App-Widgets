import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/actions/panoptic_split_button_action.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticSplitButton extends StatefulWidget {
  final ButtonType buttonType;
  final String? label;
  final CoreIcons? icon;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.margin,
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: widget.isDisabled || widget.isLoading
                  ? null
                  : widget.onPressed,
              onLongPress: widget.isDisabled || widget.isLoading
                  ? null
                  : widget.onLongPress,
              disabledColor: _getButtonColor(),
              key: widget.key,
              color: _getButtonColor(),
              textColor: _getTextColor(),
              elevation: widget.elevation,
              padding: widget.padding,
              shape: widget.actions.isEmpty ? _getShape() : _getLeftShape(),
              child: widget.isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize:
                          widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        Padding(
                          padding: (kIsWeb ||
                                  Theme.of(context).platform ==
                                      TargetPlatform.macOS ||
                                  Theme.of(context).platform ==
                                      TargetPlatform.windows)
                              ? const EdgeInsets.all(10)
                              : EdgeInsets.zero,
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation(_getTextColor()),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize:
                          widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...{
                          PanopticIcon(
                            icon: widget.icon!,
                            color: _getTextColor(),
                            size: 20,
                            margin: const EdgeInsets.only(left: 10),
                          ),
                          const SizedBox(width: 10),
                        } else if (widget.leading != null) ...{
                          widget.leading!,
                          const SizedBox(width: 10),
                        },
                        if (widget.expanded) ...{
                          Expanded(
                            child: Padding(
                              padding: (kIsWeb ||
                                      Theme.of(context).platform ==
                                          TargetPlatform.macOS ||
                                      Theme.of(context).platform ==
                                          TargetPlatform.windows)
                                  ? const EdgeInsets.all(10)
                                  : EdgeInsets.zero,
                              child: Text(
                                widget.label ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: _getTextColor(),
                                    ),
                                textAlign: _getButtonLabelAlignment(),
                              ),
                            ),
                          ),
                        } else ...{
                          Padding(
                            padding: (kIsWeb ||
                                    Theme.of(context).platform ==
                                        TargetPlatform.macOS ||
                                    Theme.of(context).platform ==
                                        TargetPlatform.windows)
                                ? const EdgeInsets.all(10)
                                : EdgeInsets.zero,
                            child: Text(
                              widget.label ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: _getTextColor(),
                                  ),
                              textAlign: _getButtonLabelAlignment(),
                            ),
                          ),
                        },
                        if (widget.trailing != null) ...{
                          const SizedBox(width: 10),
                          widget.trailing!,
                        },
                      ],
                    ),
            ),
          ),
          const SizedBox(width: 2),
          if (widget.actions.isNotEmpty) ...{
            MenuAnchor(
              style: MenuStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          CoreValues.cornerRadius * 0.8)))),
              alignmentOffset: const Offset(0, kIsWeb ? 5 : 0),
              childFocusNode: _buttonFocusNode,
              menuChildren: [
                for (var action in widget.actions) ...{
                  MenuItemButton(
                    leadingIcon: action.icon != null
                        ? PanopticIcon(
                            icon: action.icon!,
                            size: 20,
                            color: _getActionColor())
                        : null,
                    onPressed: action.onPressed,
                    child: Text(
                      action.label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: _getActionColor(),
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
                          ? (kIsWeb ? 53 : 36)
                          : (kIsWeb ? 57 : 40),
                      onPressed: widget.isDisabled
                          ? null
                          : () => controller.isOpen
                              ? controller.close()
                              : controller.open(),
                      disabledColor: _getButtonColor(),
                      color: _getButtonColor(),
                      textColor: _getTextColor(),
                      elevation: widget.elevation,
                      shape: _getRightShape(),
                      child: PanopticIcon(
                        icon: CoreIcons.chevrondown,
                        size: 20,
                        margin: EdgeInsets.zero,
                        color: _getTextColor(),
                      )),
                );
              },
            )
          }
        ],
      ),
    );
  }

  _getButtonColor() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return Theme.of(context).colorScheme.surface;
    }
    switch (widget.buttonType) {
      case ButtonType.primary:
        return Theme.of(context).colorScheme.primary;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case ButtonType.accent:
        return Theme.of(context).colorScheme.tertiary;
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
        return Theme.of(context).colorScheme.primary;
    }
  }

  _getActionColor() {
    switch (widget.buttonType) {
      case ButtonType.primary:
        return Theme.of(context).colorScheme.primary;
      case ButtonType.secondary:
        return Theme.of(context).colorScheme.secondary;
      case ButtonType.accent:
        return Theme.of(context).colorScheme.tertiary;
      case ButtonType.bordered:
      case ButtonType.unselected:
        return Theme.of(context).colorScheme.primary;
    }
  }

  _getLeftShape() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
              topLeft: Radius.circular(CoreValues.cornerRadius * 0.8)),
          side: BorderSide(color: Theme.of(context).colorScheme.primary));
    }
    switch (widget.buttonPosition) {
      case ButtonPosition.right:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only());
      case ButtonPosition.left:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
                topLeft: Radius.circular(CoreValues.cornerRadius * 0.8)));
      case ButtonPosition.center:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
      case ButtonPosition.na:
        return RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
              topLeft: Radius.circular(CoreValues.cornerRadius * 0.8)),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
    }
  }

  _getShape() {
    if (ThemeProvider.controllerOf(context)
        .currentThemeId
        .startsWith('white')) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            CoreValues.cornerRadius * 0.8,
          ),
          side: BorderSide(color: Theme.of(context).colorScheme.primary));
    }
    switch (widget.buttonPosition) {
      case ButtonPosition.right:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(CoreValues.cornerRadius * 0.8),
                topRight: Radius.circular(CoreValues.cornerRadius * 0.8)));
      case ButtonPosition.left:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(CoreValues.cornerRadius * 0.8),
                topLeft: Radius.circular(CoreValues.cornerRadius * 0.8)));
      case ButtonPosition.center:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
      case ButtonPosition.na:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            CoreValues.cornerRadius * 0.8,
          ),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
    }
  }

  _getRightShape() {
    switch (widget.buttonPosition) {
      case ButtonPosition.right:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(CoreValues.cornerRadius * 0.8),
                topRight: Radius.circular(CoreValues.cornerRadius * 0.8)));
      case ButtonPosition.left:
        return RoundedRectangleBorder(
            side: widget.buttonType == ButtonType.bordered
                ? BorderSide(color: Theme.of(context).colorScheme.primary)
                : BorderSide.none,
            borderRadius: const BorderRadius.only());
      case ButtonPosition.center:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
      case ButtonPosition.na:
        return RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(CoreValues.cornerRadius * 0.8),
              topRight: Radius.circular(CoreValues.cornerRadius * 0.8)),
          side: widget.buttonType == ButtonType.bordered
              ? BorderSide(color: Theme.of(context).colorScheme.primary)
              : BorderSide.none,
        );
    }
  }

  _getButtonLabelAlignment() {
    if (widget.icon != null && widget.trailing == null) {
      return TextAlign.end;
    }
    if (widget.icon == null && widget.trailing != null) {
      return TextAlign.start;
    } else {
      return TextAlign.center;
    }
  }
}
