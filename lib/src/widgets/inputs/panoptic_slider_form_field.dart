// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously, unnecessary_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticSliderFormField
    extends PanopticFormFieldDecoration<List<double>> {
  PanopticSliderFormField({
    super.key,
    super.onSaved,
    required super.name,
    super.enabled = true,
    super.onChanged,
    bool autoValidate = false,
    super.initialValue,
    String? label,
    String? hintText,
    bool readOnly = false,
    super.validator,
    double width = 400,
    bool fullWidth = false,
    bool forceColumn = false,
    required double min,
    required double max,
    bool range = false,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    EdgeInsetsGeometry leadingPadding = const EdgeInsets.all(5),
    Function(Color)? onFieldSubmitted,
    alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<double>> field) {
            final state = field as PanopticSliderFormFieldState;

            return fullWidth
                ? _buildFullWidthPicker(state, min, max, range)
                : _buildNormalPicker(state, label, hintText, width, forceColumn,
                    leadingPadding, min, max, range);
          },
        );

  static Widget _buildFullWidthPicker(
    PanopticSliderFormFieldState state,
    double min,
    double max,
    bool range,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 4,
          child: _buildSliderDisplay(state, min, max, range: range),
        ),
      ],
    );
  }

  static Widget _buildNormalPicker(
    PanopticSliderFormFieldState state,
    String? label,
    String? hintText,
    double width,
    bool forceColumn,
    EdgeInsetsGeometry leadingPadding,
    double min,
    double max,
    bool range,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PanopticResponsiveLayout(
          forceColumn: forceColumn,
          childrenPadding: const EdgeInsets.all(2),
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label != null) _buildLabel(state, label, hintText),
            Padding(padding: leadingPadding),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(state.context).size.width,
              ),
              width: forceColumn ? null : width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildSliderDisplay(state, min, max, range: range),
                  ),
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
                style: Theme.of(state.context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(state.context).colorScheme.error),
              )
            ],
          ),
      ],
    );
  }

  static Widget _buildLabel(
      PanopticSliderFormFieldState state, String label, String? hintText) {
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
            verticalOffset: 10,
            triggerMode: kIsWeb ? null : TooltipTriggerMode.tap,
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

  static Widget _buildSliderDisplay(
      PanopticSliderFormFieldState state, double min, double max,
      {bool range = false}) {
    return FlutterSlider(
      values: state.value ?? (range ? [min, max] : [min]),
      max: max,
      min: min,
      rangeSlider: range,
      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
        if (range) {
          state.didChange([lowerValue, upperValue]);
        } else {
          state.didChange([lowerValue]);
        }
      },
      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        positionOffset: FlutterSliderTooltipPositionOffset(top: -15),
        boxStyle: FlutterSliderTooltipBox(
          decoration: BoxDecoration(
              color: Theme.of(state.context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(CoreValues.cornerRadius / 2)),
        ),
      ),
      trackBar: FlutterSliderTrackBar(
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(state.context).colorScheme.onSurface,
        ),
        activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(state.context).primaryColor),
      ),
    );
  }

  @override
  PanopticFormFieldDecorationState<PanopticSliderFormField, List<double>>
      createState() => PanopticSliderFormFieldState();
}

class PanopticSliderFormFieldState extends PanopticFormFieldDecorationState<
    PanopticSliderFormField, List<double>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChange(List<double>? value) {
    super.didChange(value);
    setState(() {});
  }
}
