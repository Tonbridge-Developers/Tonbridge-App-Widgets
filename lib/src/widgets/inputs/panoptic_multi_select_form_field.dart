import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/form/panoptic_form_decoration.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

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
    //Use the alternative bg color
    alternative = false,
    bool fullWidth = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<dynamic>> field) {
            final state = field as PanopticMultiSelectFormFieldState;
            return fullWidth
                ? Column(
                    children: [
                      for (var item in items!)
                        CheckboxListTile(
                          enabled: enabled,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CoreValues.cornerRadius * 0.8),
                          ),
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CoreValues.cornerRadius / 4),
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
                        ),
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
                                for (var item in items!)
                                  CheckboxListTile(
                                    enabled: enabled,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          CoreValues.cornerRadius * 0.8),
                                    ),
                                    checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          CoreValues.cornerRadius / 4),
                                    ),
                                    title: item.child,
                                    value: state.value!.contains(item.value),
                                    onChanged: (bool? value) {
                                      if (value!) {
                                        state.didChange(
                                            [...state.value!, item.value]);
                                      } else {
                                        state.didChange(state.value!
                                            .where((element) =>
                                                element != item.value)
                                            .toList());
                                      }
                                      if (onChanged != null) {
                                        onChanged(state.value);
                                      }
                                    },
                                  ),
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
  PanopticFormFieldDecorationState<PanopticMultiSelectFormField, List<dynamic>>
      createState() => PanopticMultiSelectFormFieldState();
}

class PanopticMultiSelectFormFieldState
    extends PanopticFormFieldDecorationState<PanopticMultiSelectFormField,
        List<dynamic>> {}
