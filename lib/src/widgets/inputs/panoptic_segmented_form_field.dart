import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticSegmentedFormField extends PanopticFormFieldDecoration<int> {
  PanopticSegmentedFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.name,
    super.enabled = true,
    super.onChanged,
    super.initialValue = 0,
    bool autoValidate = false,
    String? hintText,
    String? label,
    Map<int, String>? items,
    bool forceColumn = false,
    bool fullWidth = false,
    bool alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<int> field) {
            final state = field as PanopticSegmentedFormFieldState;
            final theme = Theme.of(state.context);
            final colorScheme = theme.colorScheme;
            final surfaceColor = alternative
                ? colorScheme.surfaceContainer
                : colorScheme.surface;

            Widget buildSegmentedControl() {
              return MaterialSegmentedControl(
                disabledChildren: enabled ? null : items!.keys.toList(),
                borderRadius: CoreValues.cornerRadius * 0.8,
                borderColor: colorScheme.primary,
                unselectedColor: surfaceColor.withAlpha(55),
                disabledColor: surfaceColor,
                selectedColor: colorScheme.primary,
                children: items!.map((key, value) => MapEntry(
                    key,
                    Text(value,
                        style: TextStyle(
                          color: !enabled
                              ? colorScheme.onSurface
                              : (state.value == key
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface),
                        )))),
                onSegmentTapped: (value) {
                  state.didChange(value);
                  onChanged?.call(value as int?);
                },
                selectionIndex: state.value,
              );
            }

            return fullWidth
                ? buildSegmentedControl()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PanopticResponsiveLayout(
                        forceColumn: forceColumn,
                        childrenPadding: const EdgeInsets.all(2),
                        rowCrossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (label != null)
                            Row(
                              children: [
                                Text(
                                  label,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                if (hintText != null)
                                  Tooltip(
                                    message: hintText,
                                    preferBelow: true,
                                    verticalOffset: 10,
                                    triggerMode:
                                        PanopticExtension.isWebOrDesktop()
                                            ? null
                                            : TooltipTriggerMode.tap,
                                    child: PanopticIcon(
                                      icon: PanopticIcons.infoRound,
                                      size: 15,
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 2),
                                      color:
                                          colorScheme.onSurface.withAlpha(100),
                                    ),
                                  ),
                              ],
                            ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(state.context).size.width,
                            ),
                            width: forceColumn ? null : 400,
                            child: buildSegmentedControl(),
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
                            ),
                          ],
                        ),
                    ],
                  );
          },
        );

  @override
  PanopticFormFieldDecorationState<PanopticSegmentedFormField, int>
      createState() => PanopticSegmentedFormFieldState();
}

class PanopticSegmentedFormFieldState
    extends PanopticFormFieldDecorationState<PanopticSegmentedFormField, int> {}
