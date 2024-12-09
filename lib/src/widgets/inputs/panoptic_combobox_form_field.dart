import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticComboBoxFormField
    extends PanopticFormFieldDecoration<List<dynamic>> {
  PanopticComboBoxFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.initialValue,
    super.enabled,
    required super.name,
    super.onChanged,
    bool forceColumn = false,
    bool autoValidate = false,
    String? hintText,
    String? label,
    String? searchValue = '',
    int maxItems = 1,
    bool fullWidth = false,
    alternative = false,
    bool keyboardAction = true,
    required List<DropdownMenuItem<dynamic>>? items,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<dynamic> field) {
            final state = field as PanopticComboBoxFormFieldState;
            final theme = Theme.of(state.context);
            final colorScheme = theme.colorScheme;
            final surfaceColor = (alternative
                    ? colorScheme.surfaceContainer
                    : colorScheme.surface)
                .withAlpha(255);
            final borderColor =
                state.hasError ? colorScheme.error : colorScheme.onSurface;

            Widget buildSearchField() {
              return TextFormField(
                enabled: enabled,
                initialValue: searchValue,
                onChanged: (value) {
                  state.setState(() {
                    searchValue = value;
                  });
                },
                decoration: InputDecoration(
                  fillColor: surfaceColor,
                  filled: true,
                  contentPadding: const EdgeInsets.all(17),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(color: borderColor),
                  ),
                ),
              );
            }

            Widget buildListView() {
              return Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView(
                  children: [
                    for (var item in items!.sortedBy<num>(
                        (e) => state.value!.contains(e.value) ? 0 : 1))
                      if (item.child
                              .toString()
                              .toLowerCase()
                              .contains(searchValue!.toLowerCase()) ||
                          item.value
                              .toString()
                              .toLowerCase()
                              .contains(searchValue!.toLowerCase()) ||
                          state.value!.contains(item.value))
                        CheckboxListTile(
                          enabled: enabled,
                          title: item.child,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CoreValues.cornerRadius * 0.8),
                          ),
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CoreValues.cornerRadius / 4),
                          ),
                          value: state.value!.contains(item.value),
                          onChanged: (bool? value) {
                            if (value!) {
                              if (state.value!.length < maxItems) {
                                state.didChange([...state.value!, item.value]);
                              }
                            } else {
                              state.didChange(state.value!
                                  .where((element) => element != item.value)
                                  .toList());
                            }
                            onChanged?.call(state.value!);
                          },
                        ),
                  ],
                ),
              );
            }

            return fullWidth
                ? Column(
                    children: [
                      keyboardAction
                          ? KeyboardAction(
                              focusNode: FocusScope.of(state.context),
                              child: buildSearchField(),
                            )
                          : buildSearchField(),
                      buildListView(),
                    ],
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
                                Text(label, style: theme.textTheme.bodyLarge),
                                if (hintText != null)
                                  Tooltip(
                                    message: hintText,
                                    preferBelow: true,
                                    verticalOffset: 10,
                                    triggerMode:
                                        kIsWeb ? null : TooltipTriggerMode.tap,
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
                                maxWidth:
                                    MediaQuery.of(state.context).size.width),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  CoreValues.cornerRadius * 0.8),
                              border: (PlatformDispatcher
                                          .instance.platformBrightness ==
                                      Brightness.dark
                                  ? Border.all(
                                      width: 0.5, color: colorScheme.onSurface)
                                  : null),
                              color: surfaceColor,
                            ),
                            width: forceColumn ? null : 400,
                            child: Column(
                              children: [
                                buildSearchField(),
                                buildListView(),
                              ],
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
  PanopticFormFieldDecorationState<PanopticComboBoxFormField, List<dynamic>>
      createState() => PanopticComboBoxFormFieldState();
}

class PanopticComboBoxFormFieldState extends PanopticFormFieldDecorationState<
    PanopticComboBoxFormField, List<dynamic>> {}
