import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

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
    //Use the alternative bg color
    alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<int> field) {
            final state = field as PanopticSegmentedFormFieldState;
            return fullWidth
                ? MaterialSegmentedControl(
                    disabledChildren: enabled ? null : items!.keys.toList(),
                    borderRadius: CoreValues.cornerRadius * 0.8,
                    borderColor: Theme.of(state.context).colorScheme.primary,
                    unselectedColor: (alternative
                            ? Theme.of(state.context)
                                .colorScheme
                                .surfaceContainer
                            : Theme.of(state.context).colorScheme.surface)
                        .withAlpha(55),
                    disabledColor: (alternative
                        ? Theme.of(state.context).colorScheme.surfaceContainer
                        : Theme.of(state.context).colorScheme.surface),
                    selectedColor: Theme.of(state.context).colorScheme.primary,
                    children: items!.map((key, value) => MapEntry(
                        key,
                        Text(value,
                            style: TextStyle(
                              color: state.value == key
                                  ? Theme.of(state.context)
                                      .colorScheme
                                      .onPrimary
                                  : Theme.of(state.context)
                                      .colorScheme
                                      .onSurface,
                            )))),
                    onSegmentTapped: (value) {
                      state.didChange(value);
                      onChanged?.call(value as int?);
                    },
                    selectionIndex: state.value,
                  )
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
                                  style: Theme.of(state.context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                                if (hintText != null) ...{
                                  Tooltip(
                                    message: hintText,
                                    preferBelow: true,
                                    verticalOffset: 10,
                                    triggerMode:
                                        kIsWeb ? null : TooltipTriggerMode.tap,
                                    child: PanopticIcon(
                                      icon: CoreIcons.infoRound,
                                      size: 15,
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 2),
                                      color: Theme.of(state.context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(100),
                                    ),
                                  )
                                }
                              ],
                            ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(state.context).size.width,
                            ),
                            width: forceColumn ? null : 400,
                            child: MaterialSegmentedControl(
                              disabledChildren:
                                  enabled ? null : items!.keys.toList(),
                              borderRadius: CoreValues.cornerRadius * 0.8,
                              borderColor:
                                  Theme.of(state.context).colorScheme.primary,
                              unselectedColor: (alternative
                                      ? Theme.of(state.context)
                                          .colorScheme
                                          .surfaceContainer
                                      : Theme.of(state.context)
                                          .colorScheme
                                          .surface)
                                  .withAlpha(55),
                              disabledColor: (alternative
                                  ? Theme.of(state.context)
                                      .colorScheme
                                      .surfaceContainer
                                  : Theme.of(state.context)
                                      .colorScheme
                                      .surface),
                              selectedColor:
                                  Theme.of(state.context).colorScheme.primary,
                              children: items!.map((key, value) => MapEntry(
                                  key,
                                  Text(value,
                                      style: TextStyle(
                                        color: !enabled
                                            ? Theme.of(state.context)
                                                .colorScheme
                                                .onSurface
                                            : (state.value == key
                                                ? Theme.of(state.context)
                                                    .colorScheme
                                                    .onPrimary
                                                : Theme.of(state.context)
                                                    .colorScheme
                                                    .onSurface),
                                      )))),
                              onSegmentTapped: (value) {
                                state.didChange(value);
                                onChanged?.call(value as int?);
                              },
                              selectionIndex: state.value,
                            ),
                          ),
                        ],
                      ),
                      state.hasError
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  state.errorText ?? 'An error occurred',
                                  style: Theme.of(state.context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: Theme.of(state.context)
                                              .colorScheme
                                              .error),
                                )
                              ],
                            )
                          : Container()
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
