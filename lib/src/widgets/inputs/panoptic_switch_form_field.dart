import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticSwitchFormField extends PanopticFormFieldDecoration<bool> {
  PanopticSwitchFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.name,
    super.enabled,
    super.onChanged,
    super.initialValue = false,
    bool autoValidate = false,
    bool alternative = false,
    String? label,
    Color? activeColor,
    String? hintText,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<bool> field) {
            final state = field as PanopticSwitchFormFieldState;
            ThemeData theme = Theme.of(state.context);
            ColorScheme colorScheme = theme.colorScheme;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (label != null) ...{
                            Flexible(
                              child: Text(
                                label,
                                style: theme.textTheme.bodyLarge,
                                maxLines: 3,
                              ),
                            ),
                            if (hintText != null) ...{
                              Tooltip(
                                message: hintText,
                                preferBelow: true,
                                triggerMode:
                                    kIsWeb ? null : TooltipTriggerMode.tap,
                                verticalOffset: 10,
                                child: PanopticIcon(
                                  icon: PanopticIcons.infoRound,
                                  size: 15,
                                  margin:
                                      const EdgeInsets.only(left: 5, top: 2),
                                  color: colorScheme.onSurface.withAlpha(100),
                                ),
                              )
                            }
                          },
                        ],
                      ),
                    ),
                    Switch(
                      value: state.value ?? false,
                      trackOutlineColor: WidgetStateProperty.all(
                          colorScheme.onSurface.withOpacity(0.9)),
                      trackOutlineWidth: WidgetStateProperty.all(1),
                      activeTrackColor: activeColor ?? colorScheme.primary,
                      activeColor: activeColor?.withOpacity(0.7) ??
                          colorScheme.primary.withOpacity(0.6),
                      inactiveThumbColor:
                          colorScheme.onSurface.withOpacity(0.9),
                      trackColor: (state.value ?? false)
                          ? (WidgetStateProperty.all(
                              activeColor ?? colorScheme.primary))
                          : (alternative
                              ? WidgetStateProperty.all(
                                  colorScheme.surfaceContainer.withOpacity(0.9))
                              : WidgetStateProperty.all(
                                  colorScheme.surface.withOpacity(0.6))),
                      onChanged: enabled
                          ? (value) {
                              state.didChange(value);
                            }
                          : null,
                    ),
                  ],
                ),
                if (state.hasError)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        state.errorText ?? 'An error occurred',
                        style: theme.textTheme.labelMedium!
                            .copyWith(color: colorScheme.error),
                      )
                    ],
                  )
              ],
            );
          },
        );
  @override
  PanopticFormFieldDecorationState<PanopticSwitchFormField, bool>
      createState() => PanopticSwitchFormFieldState();
}

class PanopticSwitchFormFieldState
    extends PanopticFormFieldDecorationState<PanopticSwitchFormField, bool> {}
