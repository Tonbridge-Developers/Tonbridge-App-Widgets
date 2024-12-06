// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously, unnecessary_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticColourPickerFormField extends PanopticFormFieldDecoration<Color> {
  PanopticColourPickerFormField({
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
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    EdgeInsetsGeometry leadingPadding = const EdgeInsets.all(5),
    Function(Color)? onFieldSubmitted,
    bool keyboardAction = true,
    alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<Color> field) {
            final state = field as PanopticColourPickerFormFieldState;

            return keyboardAction
                ? KeyboardAction(
                    focusNode: FocusScope.of(state.context),
                    child: fullWidth
                        ? _buildFullWidthPicker(state)
                        : _buildNormalPicker(state, label, hintText, width,
                            forceColumn, leadingPadding),
                  )
                : fullWidth
                    ? _buildFullWidthPicker(state)
                    : _buildNormalPicker(state, label, hintText, width,
                        forceColumn, leadingPadding);
          },
        );

  static Widget _buildFullWidthPicker(
      PanopticColourPickerFormFieldState state) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 4,
          child: _buildColorDisplay(state),
        ),
        const SizedBox(width: 10),
        _buildColorPickerButton(state),
      ],
    );
  }

  static Widget _buildNormalPicker(
    PanopticColourPickerFormFieldState state,
    String? label,
    String? hintText,
    double width,
    bool forceColumn,
    EdgeInsetsGeometry leadingPadding,
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
                    child: _buildColorDisplay(state),
                  ),
                  const SizedBox(width: 10),
                  _buildColorPickerButton(state),
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

  static Widget _buildLabel(PanopticColourPickerFormFieldState state,
      String label, String? hintText) {
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

  static Widget _buildColorDisplay(PanopticColourPickerFormFieldState state) {
    return Container(
      height: 47,
      decoration: BoxDecoration(
        color: state.value,
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
      ),
      child: Center(
        child: Text(
          '#${(state.value ?? Colors.white).toHexString().substring(2)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: Theme.of(state.context).textTheme.bodyLarge!.fontStyle,
            color: state.value!.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget _buildColorPickerButton(
      PanopticColourPickerFormFieldState state) {
    return PanopticIconButton(
      icon: PanopticIcons.paint,
      size: 50,
      onTap: () {
        showDialog(
          context: state.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select a colour:'),
              content: SingleChildScrollView(
                child: HueRingPicker(
                  pickerColor: state.value ??
                      Theme.of(state.context).colorScheme.primary,
                  portraitOnly: true,
                  onColorChanged: state.didChange,
                  enableAlpha: false,
                  displayThumbColor: true,
                ),
              ),
              actions: <Widget>[
                PanopticButton(
                  label: 'Done',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  PanopticFormFieldDecorationState<PanopticColourPickerFormField, Color>
      createState() => PanopticColourPickerFormFieldState();
}

class PanopticColourPickerFormFieldState
    extends PanopticFormFieldDecorationState<PanopticColourPickerFormField,
        Color> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChange(Color? value) {
    super.didChange(value);
    setState(() {});
  }
}
