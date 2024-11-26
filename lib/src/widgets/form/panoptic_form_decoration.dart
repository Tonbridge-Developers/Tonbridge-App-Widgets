import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/widgets/form/panoptic_form_field.dart';

/// Extends [PanopticFormField] and add a `decoration` (InputDecoration) property
///
/// This class override `decoration.enable` with [enable] value
class PanopticFormFieldDecoration<T> extends PanopticFormField<T> {
  const PanopticFormFieldDecoration({
    super.key,
    super.onSaved,
    super.initialValue,
    super.autovalidateMode,
    super.enabled = true,
    super.validator,
    super.restorationId,
    required super.name,
    super.valueTransformer,
    super.onChanged,
    super.onReset,
    super.focusNode,
    required super.builder,
    this.decoration = const InputDecoration(),
  });
  final InputDecoration decoration;

  @override
  PanopticFormFieldDecorationState<PanopticFormFieldDecoration<T>, T>
      createState() =>
          PanopticFormFieldDecorationState<PanopticFormFieldDecoration<T>, T>();
}

class PanopticFormFieldDecorationState<F extends PanopticFormFieldDecoration<T>,
    T> extends PanopticFormFieldState<PanopticFormField<T>, T> {
  @override
  F get widget => super.widget as F;

  @override
  bool get hasError => super.hasError || widget.decoration.errorText != null;

  @override
  bool get isValid => super.isValid && widget.decoration.errorText == null;
}
