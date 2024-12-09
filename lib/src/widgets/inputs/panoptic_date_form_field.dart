// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/date_time_picker/board_datetime_options.dart';
import 'package:panoptic_widgets/src/widgets/date_time_picker/board_datetime_widget.dart';

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
                ? _buildFullWidthContainer(state, enabled, alternative,
                    buttonLabel, useDatePicker, useTimePicker)
                : _buildColumn(
                    state,
                    enabled,
                    alternative,
                    buttonLabel,
                    useDatePicker,
                    useTimePicker,
                    label,
                    hintText,
                    checked,
                    checkedEnabled,
                    forceColumn);
          },
        );

  static Widget _buildFullWidthContainer(
      PanopticDateFormFieldState state,
      bool enabled,
      bool alternative,
      String? buttonLabel,
      bool useDatePicker,
      bool useTimePicker) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(state.context).size.width,
        minWidth: MediaQuery.of(state.context).size.width,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
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
                ? Theme.of(state.context).colorScheme.surfaceContainer
                : Theme.of(state.context).colorScheme.surface)
            .withAlpha(255),
      ),
      child: TextButton(
        onPressed: enabled
            ? () =>
                _pickDateTime(state, buttonLabel, useDatePicker, useTimePicker)
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
                    .withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  static Widget _buildColumn(
      PanopticDateFormFieldState state,
      bool enabled,
      bool alternative,
      String? buttonLabel,
      bool useDatePicker,
      bool useTimePicker,
      String? label,
      String? hintText,
      bool checked,
      bool checkedEnabled,
      bool forceColumn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PanopticResponsiveLayout(
          forceColumn: forceColumn,
          childrenPadding: const EdgeInsets.all(2),
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label != null) _buildLabel(state, label, hintText),
            const Padding(padding: EdgeInsets.all(5)),
            if (checked)
              _buildCheckedRow(state, enabled, alternative, buttonLabel,
                  useDatePicker, useTimePicker, checkedEnabled)
            else
              _buildUncheckedContainer(state, enabled, alternative, buttonLabel,
                  useDatePicker, useTimePicker, forceColumn),
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
                    .copyWith(color: Theme.of(state.context).colorScheme.error),
              ),
            ],
          ),
      ],
    );
  }

  static Widget _buildLabel(
      PanopticDateFormFieldState state, String label, String? hintText) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(state.context).textTheme.bodyLarge,
        ),
        if (hintText != null)
          Tooltip(
            message: hintText,
            preferBelow: true,
            triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
            verticalOffset: 10,
            child: PanopticIcon(
              icon: PanopticIcons.infoRound,
              size: 15,
              margin: const EdgeInsets.only(left: 5, top: 2),
              color:
                  Theme.of(state.context).colorScheme.onSurface.withAlpha(100),
            ),
          ),
      ],
    );
  }

  static Widget _buildCheckedRow(
      PanopticDateFormFieldState state,
      bool enabled,
      bool alternative,
      String? buttonLabel,
      bool useDatePicker,
      bool useTimePicker,
      bool checkedEnabled) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildCheckedContainer(state, enabled, alternative, buttonLabel,
            useDatePicker, useTimePicker, checkedEnabled),
        const SizedBox(width: 10),
        !checkedEnabled
            ? PanopticIconButton(
                icon: PanopticIcons.edit,
                size: 50,
                isDisabled: !enabled,
                onTap: () {
                  state.setState(() {
                    checkedEnabled = true;
                  });
                },
              )
            : PanopticIconButton(
                icon: PanopticIcons.cross,
                size: 50,
                isDisabled: !enabled,
                onTap: () {
                  state.setState(() {
                    checkedEnabled = false;
                    state.didChange(state.widget.initialValue);
                  });
                },
              ),
      ],
    );
  }

  static Widget _buildCheckedContainer(
      PanopticDateFormFieldState state,
      bool enabled,
      bool alternative,
      String? buttonLabel,
      bool useDatePicker,
      bool useTimePicker,
      bool checkedEnabled) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(state.context).size.width,
      ),
      width: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        border: Border.all(
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : checkedEnabled && enabled
                  ? Theme.of(state.context).colorScheme.outline
                  : Theme.of(state.context)
                      .colorScheme
                      .outline
                      .withOpacity(0.4),
        ),
        color: (alternative
                ? Theme.of(state.context).colorScheme.surfaceContainer
                : Theme.of(state.context).colorScheme.surface)
            .withAlpha(255),
      ),
      child: TextButton(
        onPressed: enabled && checkedEnabled
            ? () =>
                _pickDateTime(state, buttonLabel, useDatePicker, useTimePicker)
            : null,
        child: Text(
          state.value != null
              ? PanopticExtension.formatDate(state.value!,
                  format:
                      "${useDatePicker ? "dd/MM/yyyy" : ""} ${useTimePicker ? "HH:mm" : ""}")
              : (buttonLabel ?? 'Select Date'),
          style: TextStyle(
            color: checkedEnabled && enabled
                ? Theme.of(state.context).colorScheme.onSurface
                : Theme.of(state.context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  static Widget _buildUncheckedContainer(
      PanopticDateFormFieldState state,
      bool enabled,
      bool alternative,
      String? buttonLabel,
      bool useDatePicker,
      bool useTimePicker,
      bool forceColumn) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(state.context).size.width,
      ),
      width: forceColumn ? MediaQuery.of(state.context).size.width : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
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
                ? Theme.of(state.context).colorScheme.surfaceContainer
                : Theme.of(state.context).colorScheme.surface)
            .withAlpha(255),
      ),
      child: TextButton(
        onPressed: enabled
            ? () =>
                _pickDateTime(state, buttonLabel, useDatePicker, useTimePicker)
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
                    .withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  static Future<void> _pickDateTime(PanopticDateFormFieldState state,
      String? buttonLabel, bool useDatePicker, bool useTimePicker) async {
    final DateTime? picked = await showBoardDateTimePicker(
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
        pickerSubTitles: const BoardDateTimeItemTitles(
          day: 'Day',
          month: 'Month',
          year: 'Year',
          hour: 'Hour',
          minute: 'Minute',
        ),
      ),
    );

    if (picked != null && picked != state.value) {
      state.didChange(picked);
      state.widget.onChanged?.call(picked);
    }
  }

  @override
  PanopticFormFieldDecorationState<PanopticDateFormField, DateTime>
      createState() => PanopticDateFormFieldState();
}

class PanopticDateFormFieldState
    extends PanopticFormFieldDecorationState<PanopticDateFormField, DateTime> {}
