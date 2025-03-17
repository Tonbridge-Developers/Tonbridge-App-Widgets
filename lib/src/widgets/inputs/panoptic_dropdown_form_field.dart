// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticDropdownFormField extends PanopticFormFieldDecoration<dynamic> {
  final bool forceColumn;
  final bool autoValidate;
  final bool checked;
  final bool alternative;
  final bool fullWidth;
  final String? label;
  final String? hintText;
  final String placeholder;
  final Widget? icon;
  final Widget? nullLabel;
  final List<DropdownMenuItem<dynamic>>? items;

  PanopticDropdownFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required super.name,
    super.enabled,
    super.onChanged,
    this.forceColumn = false,
    this.autoValidate = false,
    this.label,
    this.hintText,
    this.placeholder = 'Select an option',
    this.icon,
    this.checked = false,
    bool checkedEnabled = false,
    this.items,
    this.alternative = false,
    this.fullWidth = false,
    this.nullLabel,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<dynamic> field) {
            final state = field as PanopticDropdownFormFieldState;
            final labelWidget = _buildLabelWidget(label, hintText, state);
            final dropdownDecoration = _buildInputDecoration(
                state, alternative, placeholder, checkedEnabled, enabled);

            return fullWidth
                ? _buildFullWidthDropdown(state, dropdownDecoration, icon,
                    placeholder, items, nullLabel, enabled, onChanged, onSaved)
                : _buildColumnDropdown(
                    state,
                    labelWidget,
                    dropdownDecoration,
                    icon,
                    placeholder,
                    items,
                    nullLabel,
                    enabled,
                    onChanged,
                    onSaved,
                    forceColumn,
                    checked,
                    checkedEnabled,
                    initialValue,
                  );
          },
        );

  static Widget? _buildLabelWidget(
      String? label, String? hintText, PanopticDropdownFormFieldState state) {
    if (label.isNullOrWhitespace) return null;
    return Row(
      children: [
        Text(
          label!,
          style: Theme.of(state.context).textTheme.bodyLarge,
        ),
        if (hintText != null)
          Tooltip(
            message: hintText,
            preferBelow: true,
            triggerMode: PanopticExtension.isWebOrDesktop()
                ? null
                : TooltipTriggerMode.tap,
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

  static InputDecoration _buildInputDecoration(
      PanopticDropdownFormFieldState state,
      bool alternative,
      String placeholder,
      bool checkedEnabled,
      bool enabled) {
    return InputDecoration(
      fillColor: (alternative
              ? Theme.of(state.context).colorScheme.surfaceContainer
              : Theme.of(state.context).colorScheme.surface)
          .withAlpha(255),
      filled: true,
      suffixIcon: state.value != null && checkedEnabled && enabled
          ? GestureDetector(
              onTap: () {
                state.didChange(null);
              },
              child: Icon(
                Icons.clear,
                color: Theme.of(state.context).colorScheme.onSurface,
              ),
            )
          : null,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : Theme.of(state.context).colorScheme.onSurface,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : enabled
                  ? Theme.of(state.context).colorScheme.outline
                  : Theme.of(state.context)
                      .colorScheme
                      .outline
                      .withOpacity(0.4),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          width: 1,
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : Theme.of(state.context).colorScheme.onSurface,
        ),
      ),
      error: const SizedBox.shrink(),
      contentPadding: const EdgeInsets.all(15),
    );
  }

  static Widget _buildFullWidthDropdown(
      PanopticDropdownFormFieldState state,
      InputDecoration dropdownDecoration,
      Widget? icon,
      String placeholder,
      List<DropdownMenuItem<dynamic>>? items,
      Widget? nullLabel,
      bool enabled,
      ValueChanged<dynamic>? onChanged,
      FormFieldSetter<dynamic>? onSaved) {
    return DropdownButtonFormField<dynamic>(
      key: Key(state.widget.name),
      isExpanded: true,
      disabledHint: Text(
        placeholder,
        style: const TextStyle().copyWith(
          color: Theme.of(state.context).disabledColor,
        ),
      ),
      value: state.value,
      items: _buildItems(items, nullLabel),
      onChanged: enabled
          ? (value) {
              onChanged?.call(value);
            }
          : null,
      enableFeedback: true,
      autovalidateMode: state.widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      onSaved: onSaved,
      hint: Text(placeholder),
      icon: icon,
      decoration: dropdownDecoration,
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
    );
  }

  static Widget _buildColumnDropdown(
      PanopticDropdownFormFieldState state,
      Widget? labelWidget,
      InputDecoration dropdownDecoration,
      Widget? icon,
      String placeholder,
      List<DropdownMenuItem<dynamic>>? items,
      Widget? nullLabel,
      bool enabled,
      ValueChanged<dynamic>? onChanged,
      FormFieldSetter<dynamic>? onSaved,
      bool forceColumn,
      bool checked,
      bool checkedEnabled,
      dynamic initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PanopticResponsiveLayout(
          forceColumn: forceColumn,
          childrenPadding: const EdgeInsets.all(2),
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (labelWidget != null) labelWidget,
            const Padding(padding: EdgeInsets.all(5)),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(state.context).size.width,
              ),
              width: forceColumn ? null : 400,
              child: checked
                  ? _buildCheckedDropdown(
                      state,
                      dropdownDecoration,
                      icon,
                      placeholder,
                      items,
                      nullLabel,
                      enabled,
                      onChanged,
                      onSaved,
                      checkedEnabled,
                      initialValue)
                  : _buildUnCheckedDropdown(
                      state,
                      dropdownDecoration,
                      icon,
                      placeholder,
                      items,
                      nullLabel,
                      enabled,
                      onChanged,
                      onSaved),
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
                    .copyWith(color: Theme.of(state.context).colorScheme.error),
              ),
            ],
          ),
      ],
    );
  }

  static Widget _buildCheckedDropdown(
      PanopticDropdownFormFieldState state,
      InputDecoration dropdownDecoration,
      Widget? icon,
      String placeholder,
      List<DropdownMenuItem<dynamic>>? items,
      Widget? nullLabel,
      bool enabled,
      ValueChanged<dynamic>? onChanged,
      FormFieldSetter<dynamic>? onSaved,
      bool checkedEnabled,
      dynamic initialValue) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 4,
          child: DropdownButtonFormField<dynamic>(
            isExpanded: true,
            key: Key(state.widget.name),
            disabledHint: Text(
              placeholder,
              style: const TextStyle().copyWith(
                color: Theme.of(state.context).disabledColor,
              ),
            ),
            value: state.value,
            items: _buildItems(items, nullLabel),
            onChanged: enabled && checkedEnabled
                ? (value) {
                    onChanged?.call(value);
                  }
                : null,
            enableFeedback: true,
            autovalidateMode: state.widget.autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            onSaved: onSaved,
            hint: Text(placeholder),
            icon: icon,
            autofocus: false,
            decoration: dropdownDecoration,
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
          ),
        ),
        const SizedBox(width: 10),
        PanopticIconButton(
          icon: checkedEnabled ? PanopticIcons.cross : PanopticIcons.edit,
          size: 50,
          isDisabled: !enabled,
          onTap: () {
            state.setState(() {
              checkedEnabled = !checkedEnabled;
              if (!checkedEnabled) {
                state.didChange(initialValue);
              }
            });
          },
        ),
      ],
    );
  }

  static Widget _buildUnCheckedDropdown(
      PanopticDropdownFormFieldState state,
      InputDecoration dropdownDecoration,
      Widget? icon,
      String placeholder,
      List<DropdownMenuItem<dynamic>>? items,
      Widget? nullLabel,
      bool enabled,
      ValueChanged<dynamic>? onChanged,
      FormFieldSetter<dynamic>? onSaved) {
    return DropdownButtonFormField<dynamic>(
      key: Key(state.widget.name),
      isExpanded: true,
      disabledHint: Text(
        placeholder,
        style: const TextStyle().copyWith(
          color: Theme.of(state.context).disabledColor,
        ),
      ),
      value: state.value,
      items: _buildItems(items, nullLabel),
      onChanged: enabled
          ? (value) {
              state.didChange(value);
              // onChanged?.call(value);
            }
          : null,
      enableFeedback: true,
      autovalidateMode: state.widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      onSaved: onSaved,
      hint: Text(placeholder),
      icon: icon,
      decoration: dropdownDecoration,
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
    );
  }

  static List<DropdownMenuItem<dynamic>> _buildItems(
      List<DropdownMenuItem<dynamic>>? items, Widget? nullLabel) {
    items ??= [];
    if (nullLabel == null) {
      return items;
    }
    return List.from(items)
      ..insert(0, DropdownMenuItem(value: null, child: nullLabel));
  }

  @override
  PanopticFormFieldDecorationState<PanopticDropdownFormField, dynamic>
      createState() => PanopticDropdownFormFieldState();
}

class PanopticDropdownFormFieldState extends PanopticFormFieldDecorationState<
    PanopticDropdownFormField, dynamic> {}
