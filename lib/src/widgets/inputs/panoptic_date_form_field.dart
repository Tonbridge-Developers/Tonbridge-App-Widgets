// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/date_time_picker/board_datetime_options.dart';
import 'package:panoptic_widgets/src/widgets/date_time_picker/board_datetime_widget.dart';
import 'package:panoptic_widgets/src/widgets/form/panoptic_form_decoration.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

class PanopticDateFormField extends PanopticFormFieldDecoration<DateTime> {
  PanopticDateFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required super.name,
    super.enabled = true,
    super.onChanged,
    DateTime? firstDate,
    DateTime? lastDate,
    bool autoValidate = false,
    bool useTimePicker = false,
    bool useDatePicker = true,
    bool checked = false,
    bool checkedEnabled = false,
    String? hintText,
    bool forceColumn = false,

    //Use the alternative bg color
    alternative = false,
    String? label,
    String? buttonLabel,
    bool fullWidth = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<DateTime> field) {
            final state = field as PanopticDateFormFieldState;
            return fullWidth
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(state.context).size.width,
                      minWidth: MediaQuery.of(state.context).size.width,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            CoreValues.cornerRadius * 0.8),
                        border: Border.all(
                          color: state.hasError
                              ? Theme.of(state.context).colorScheme.error
                              : enabled
                                  ? Theme.of(state.context).colorScheme.outline
                                  : Theme.of(state.context)
                                      .colorScheme
                                      .outline
                                      .withOpacity(0.4),
                        ),
                        color: (alternative
                                ? Theme.of(state.context)
                                    .colorScheme
                                    .surfaceContainer
                                : Theme.of(state.context).colorScheme.surface)
                            .withAlpha(55)),
                    child: TextButton(
                      onPressed: enabled
                          ? () async {
                              final DateTime? picked =
                                  await showBoardDateTimePicker(
                                context: state.context,
                                pickerType: useDatePicker && useTimePicker
                                    ? DateTimePickerType.datetime
                                    : useTimePicker
                                        ? DateTimePickerType.time
                                        : DateTimePickerType.date,
                                initialDate: state.value ?? DateTime.now(),
                                radius: CoreValues.cornerRadius,
                                isDismissible: false,
                                options: BoardDateTimeOptions(
                                    boardTitle: buttonLabel ?? 'Select Date',
                                    showDateButton: false,
                                    pickerFormat: PickerFormat.dmy,
                                    pickerSubTitles:
                                        const BoardDateTimeItemTitles(
                                      day: 'Day',
                                      month: 'Month',
                                      year: 'Year',
                                      hour: 'Hour',
                                      minute: 'Minute',
                                    )),
                              );

                              if (picked != null && picked != state.value) {
                                state.didChange(picked);
                                onChanged?.call(picked);
                              }
                            }
                          : null,
                      child: Text(
                        state.value != null
                            ? PanopticExtension.formatDate(state.value!,
                                format:
                                    "${useDatePicker ? "dd/MM/yyyy" : ""} ${useTimePicker ? "HH:mm" : ""}")
                            : (buttonLabel ?? 'Select Date'),
                        style: TextStyle(
                            color: enabled
                                ? Theme.of(state.context).colorScheme.onSurface
                                : Theme.of(state.context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4)),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PanopticResponsiveLayout(
                        forceColumn: forceColumn,
                        childrenPadding: const EdgeInsets.all(2),
                        rowCrossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (label != null) ...{
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
                                    triggerMode:
                                        kIsWeb ? null : TooltipTriggerMode.tap,
                                    verticalOffset: 10,
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
                          },
                          const Padding(padding: EdgeInsets.all(5)),
                          if (checked) ...{
                            Row(
                              // If chcecked == true
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(state.context).size.width,
                                  ),
                                  width: 340,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          CoreValues.cornerRadius * 0.8),
                                      border: Border.all(
                                        color: state.hasError
                                            ? Theme.of(state.context)
                                                .colorScheme
                                                .error
                                            : checkedEnabled && enabled
                                                ? Theme.of(state.context)
                                                    .colorScheme
                                                    .outline
                                                : Theme.of(state.context)
                                                    .colorScheme
                                                    .outline
                                                    .withOpacity(0.4),
                                      ),
                                      color: (alternative
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .surfaceContainer
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .surface)
                                          .withAlpha(55)),
                                  child: TextButton(
                                    onPressed: enabled && checkedEnabled
                                        ? () async {
                                            final DateTime? picked =
                                                await showBoardDateTimePicker(
                                              context: state.context,
                                              pickerType: useDatePicker &&
                                                      useTimePicker
                                                  ? DateTimePickerType.datetime
                                                  : useTimePicker
                                                      ? DateTimePickerType.time
                                                      : DateTimePickerType.date,
                                              initialDate:
                                                  state.value ?? DateTime.now(),
                                              radius: CoreValues.cornerRadius,
                                              isDismissible: false,
                                              options: BoardDateTimeOptions(
                                                  boardTitle: buttonLabel ??
                                                      'Select Date',
                                                  activeColor:
                                                      Theme.of(state.context)
                                                          .colorScheme
                                                          .primary,
                                                  showDateButton: false,
                                                  pickerFormat:
                                                      PickerFormat.dmy,
                                                  pickerSubTitles:
                                                      const BoardDateTimeItemTitles(
                                                    day: 'Day',
                                                    month: 'Month',
                                                    year: 'Year',
                                                    hour: 'Hour',
                                                    minute: 'Minute',
                                                  )),
                                            );
                                            if (picked != null &&
                                                picked != state.value) {
                                              state.didChange(picked);
                                              onChanged?.call(picked);
                                            }
                                          }
                                        : null,
                                    child: Text(
                                      state.value != null
                                          ? PanopticExtension.formatDate(
                                              state.value!,
                                              format:
                                                  "${useDatePicker ? "dd/MM/yyyy" : ""} ${useTimePicker ? "HH:mm" : ""}")
                                          : (buttonLabel ?? 'Select Date'),
                                      style: TextStyle(
                                          color: checkedEnabled && enabled
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.4)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                !checkedEnabled
                                    ? PanopticIconButton(
                                        icon: CoreIcons.edit,
                                        size: 50,
                                        isDisabled: !enabled,
                                        onTap: () {
                                          state.setState(() {
                                            checkedEnabled = true;
                                          });
                                        },
                                      )
                                    : PanopticIconButton(
                                        icon: CoreIcons.cross,
                                        size: 50,
                                        isDisabled: !enabled,
                                        onTap: () {
                                          state.setState(() {
                                            checkedEnabled = false;
                                            state.didChange(initialValue);
                                          });
                                        },
                                      ),
                              ],
                            )
                          } else ...{
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(state.context).size.width,
                              ),
                              width: forceColumn
                                  ? (MediaQuery.of(state.context).size.width)
                                  : 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      CoreValues.cornerRadius * 0.8),
                                  border: Border.all(
                                    color: state.hasError
                                        ? Theme.of(state.context)
                                            .colorScheme
                                            .error
                                        : enabled
                                            ? Theme.of(state.context)
                                                .colorScheme
                                                .outline
                                            : Theme.of(state.context)
                                                .colorScheme
                                                .outline
                                                .withOpacity(0.4),
                                  ),
                                  color: (alternative
                                          ? Theme.of(state.context)
                                              .colorScheme
                                              .surfaceContainer
                                          : Theme.of(state.context)
                                              .colorScheme
                                              .surface)
                                      .withAlpha(55)),
                              child: TextButton(
                                onPressed: enabled
                                    ? () async {
                                        final DateTime? picked =
                                            await showBoardDateTimePicker(
                                          context: state.context,
                                          pickerType:
                                              useDatePicker && useTimePicker
                                                  ? DateTimePickerType.datetime
                                                  : useTimePicker
                                                      ? DateTimePickerType.time
                                                      : DateTimePickerType.date,
                                          initialDate:
                                              state.value ?? DateTime.now(),
                                          isDismissible: false,
                                          radius: CoreValues.cornerRadius,
                                          options: BoardDateTimeOptions(
                                              boardTitle:
                                                  buttonLabel ?? 'Select Date',
                                              showDateButton: false,
                                              pickerFormat: PickerFormat.dmy,
                                              pickerSubTitles:
                                                  const BoardDateTimeItemTitles(
                                                day: 'Day',
                                                month: 'Month',
                                                year: 'Year',
                                                hour: 'Hour',
                                                minute: 'Minute',
                                              )),
                                        );

                                        if (picked != null &&
                                            picked != state.value) {
                                          state.didChange(picked);
                                          onChanged?.call(picked);
                                        }
                                      }
                                    : null,
                                child: Text(
                                  state.value != null
                                      ? PanopticExtension.formatDate(
                                          state.value!,
                                          format:
                                              "${useDatePicker ? "dd/MM/yyyy" : ""} ${useTimePicker ? "HH:mm" : ""}")
                                      : (buttonLabel ?? 'Select Date'),
                                  style: TextStyle(
                                      color: enabled
                                          ? Theme.of(state.context)
                                              .colorScheme
                                              .onSurface
                                          : Theme.of(state.context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.4)),
                                ),
                              ),
                            )
                          },
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
  PanopticFormFieldDecorationState<PanopticDateFormField, DateTime>
      createState() => PanopticDateFormFieldState();
}

class PanopticDateFormFieldState
    extends PanopticFormFieldDecorationState<PanopticDateFormField, DateTime> {}
