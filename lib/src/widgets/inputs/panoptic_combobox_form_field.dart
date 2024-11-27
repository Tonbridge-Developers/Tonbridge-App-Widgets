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

    ///Use the alternative bg color
    alternative = false,
    required List<DropdownMenuItem<dynamic>>? items,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<dynamic> field) {
            final state = field as PanopticComboBoxFormFieldState;
            return fullWidth
                ? Column(
                    children: [
                      KeyboardAction(
                        focusNode: FocusScope.of(state.context),
                        child: TextFormField(
                          enabled: enabled,
                          initialValue: searchValue,
                          onChanged: (value) {
                            // ignore: invalid_use_of_protected_member
                            state.setState(() {
                              searchValue = value;
                            });
                          },
                          decoration: InputDecoration(
                              fillColor: (alternative
                                      ? Theme.of(state.context)
                                          .colorScheme
                                          .surfaceContainer
                                      : Theme.of(state.context)
                                          .colorScheme
                                          .surface)
                                  .withAlpha(55),
                              filled: true,
                              contentPadding: const EdgeInsets.all(17),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    CoreValues.cornerRadius * 0.8),
                                borderSide: BorderSide(
                                    color: state.hasError
                                        ? Theme.of(state.context)
                                            .colorScheme
                                            .error
                                        : Theme.of(state.context)
                                            .colorScheme
                                            .onSurface),
                              )),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: ListView(
                          children: [
                            for (var item in items!)
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
                                        state.didChange(
                                            [...state.value!, item.value]);
                                      }
                                    } else {
                                      state.didChange(state.value!
                                          .where((element) =>
                                              element != item.value)
                                          .toList());
                                    }
                                    onChanged?.call(state.value!);
                                  },
                                ),
                          ],
                        ),
                      )
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
                                  .withAlpha(55),
                            ),
                            width: forceColumn ? null : 400,
                            child: Column(
                              children: [
                                TextFormField(
                                  enabled: enabled,
                                  initialValue: searchValue,
                                  onChanged: (value) {
                                    // ignore: invalid_use_of_protected_member
                                    state.setState(() {
                                      searchValue = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      fillColor: (alternative
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .surfaceContainer
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .surface)
                                          .withAlpha(55),
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(17),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                            color: state.hasError
                                                ? Theme.of(state.context)
                                                    .colorScheme
                                                    .error
                                                : Theme.of(state.context)
                                                    .colorScheme
                                                    .onSurface),
                                      )),
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                  ),
                                  child: ListView(
                                    children: [
                                      for (var item in items!)
                                        if (item.child.toString().toLowerCase().contains(
                                                searchValue!.toLowerCase()) ||
                                            item.value
                                                .toString()
                                                .toLowerCase()
                                                .contains(searchValue!
                                                    .toLowerCase()) ||
                                            state.value!.contains(item.value))
                                          CheckboxListTile(
                                            enabled: enabled,
                                            title: item.child,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                            ),
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius /
                                                          4),
                                            ),
                                            value: state.value!
                                                .contains(item.value),
                                            onChanged: (bool? value) {
                                              if (value!) {
                                                if (state.value!.length <
                                                    maxItems) {
                                                  state.didChange([
                                                    ...state.value!,
                                                    item.value
                                                  ]);
                                                }
                                              } else {
                                                state.didChange(state.value!
                                                    .where((element) =>
                                                        element != item.value)
                                                    .toList());
                                              }
                                              onChanged?.call(state.value!);
                                            },
                                          ),
                                    ],
                                  ),
                                )
                              ],
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
  PanopticFormFieldDecorationState<PanopticComboBoxFormField, List<dynamic>>
      createState() => PanopticComboBoxFormFieldState();
}

class PanopticComboBoxFormFieldState extends PanopticFormFieldDecorationState<
    PanopticComboBoxFormField, List<dynamic>> {}
