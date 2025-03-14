import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticMultiSelectFormField
    extends PanopticFormFieldDecoration<List<dynamic>> {
  PanopticMultiSelectFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.initialValue,
    required super.name,
    super.enabled,
    super.onChanged,
    bool autoValidate = false,
    String? hintText,
    bool forceColumn = false,
    String? label,
    List<DropdownMenuItem<dynamic>>? items,
    // Use the alternative bg color
    alternative = false,
    bool fullWidth = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<dynamic>> field) {
            final state = field as PanopticMultiSelectFormFieldState;

            Widget buildCheckboxListTile(DropdownMenuItem<dynamic> item) {
              return CheckboxListTile(
                enabled: enabled,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                ),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(CoreValues.cornerRadius / 4),
                ),
                title: item.child,
                value: state.value!.contains(item.value),
                onChanged: (bool? value) {
                  if (value!) {
                    state.didChange([...state.value!, item.value]);
                  } else {
                    state.didChange(state.value!
                        .where((element) => element != item.value)
                        .toList());
                  }
                  if (onChanged != null) {
                    onChanged(state.value);
                  }
                },
              );
            }

            return fullWidth
                ? Column(
                    children: items!.map(buildCheckboxListTile).toList(),
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
                                      color: Theme.of(state.context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(100),
                                    ),
                                  ),
                              ],
                            ),
                          const Padding(padding: EdgeInsets.all(5)),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(state.context).size.width,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  CoreValues.cornerRadius * 0.8),
                              border: (PlatformDispatcher
                                          .instance.platformBrightness ==
                                      Brightness.dark
                                  ? Border.all(
                                      width: 0.5,
                                      color: Theme.of(state.context)
                                          .colorScheme
                                          .onSurface)
                                  : null),
                              color: (alternative
                                      ? Theme.of(state.context)
                                          .colorScheme
                                          .surfaceContainer
                                      : Theme.of(state.context)
                                          .colorScheme
                                          .surface)
                                  .withAlpha(255),
                            ),
                            width: forceColumn ? null : 400,
                            child: Column(
                              children:
                                  items!.map(buildCheckboxListTile).toList(),
                            ),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Row(
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
                            ),
                          ],
                        ),
                    ],
                  );
          },
        );

  @override
  PanopticFormFieldDecorationState<PanopticMultiSelectFormField, List<dynamic>>
      createState() => PanopticMultiSelectFormFieldState();
}

class PanopticMultiSelectFormFieldState
    extends PanopticFormFieldDecorationState<PanopticMultiSelectFormField,
        List<dynamic>> {}
