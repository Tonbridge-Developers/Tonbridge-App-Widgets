import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticCheckboxFormField extends PanopticFormFieldDecoration<bool> {
  PanopticCheckboxFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.name,
    super.enabled,
    super.onChanged,
    super.initialValue = false,
    bool autoValidate = false,
    String? label,
    Color? activeColor,
    String? hintText,
    bool fullWidth = false,
  }) : super(
          autovalidateMode: autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          builder: (FormFieldState<bool> field) {
            final state = field as PanopticCheckboxFormFieldState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCheckboxRow(state, label, hintText, activeColor),
                if (state.hasError) _buildErrorText(state),
              ],
            );
          },
        );

  static Widget _buildCheckboxRow(
    PanopticCheckboxFormFieldState state,
    String? label,
    String? hintText,
    Color? activeColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (label != null) ...[
                Flexible(
                  child: Text(
                    label,
                    style: Theme.of(state.context).textTheme.bodyLarge,
                    softWrap: true,
                    maxLines: 3,
                  ),
                ),
                if (hintText != null) _buildHintIcon(state, hintText),
              ],
            ],
          ),
        ),
        Checkbox(
          value: state.value,
          onChanged: state.widget.enabled ? (value) => state.didChange(value) : null,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 4),
          ),
          activeColor: activeColor ?? Theme.of(state.context).colorScheme.primary,
        ),
      ],
    );
  }

  static Widget _buildHintIcon(PanopticCheckboxFormFieldState state, String hintText) {
    return Tooltip(
      message: hintText,
      preferBelow: true,
      triggerMode: PanopticExtension.isWebOrDesktop() ? null : TooltipTriggerMode.tap,
      verticalOffset: 10,
      child: PanopticIcon(
        icon: PanopticIcons.infoRound,
        size: 15,
        margin: const EdgeInsets.only(left: 5, top: 2),
        color: Theme.of(state.context).colorScheme.onSurface.withAlpha(100),
      ),
    );
  }

  static Widget _buildErrorText(PanopticCheckboxFormFieldState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          state.errorText ?? 'An error occurred',
          style: Theme.of(state.context).textTheme.labelMedium!.copyWith(
                color: Theme.of(state.context).colorScheme.error,
              ),
        ),
      ],
    );
  }

  @override
  PanopticFormFieldDecorationState<PanopticCheckboxFormField, bool> createState() =>
      PanopticCheckboxFormFieldState();
}

class PanopticCheckboxFormFieldState
    extends PanopticFormFieldDecorationState<PanopticCheckboxFormField, bool> {}
