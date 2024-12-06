import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticDecimalFormField extends PanopticFormFieldDecoration<String> {
  final TextEditingController? controller;

  PanopticDecimalFormField({
    super.key,
    super.onSaved,
    super.validator,
    required super.name,
    super.enabled = true,
    super.onChanged,
    bool autoValidate = false,
    this.controller,
    bool forceColumn = false,
    double? initialValue,
    String? label,
    String? hintText,
    Widget? icon,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    Widget? trailing,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    EdgeInsetsGeometry leadingPadding = const EdgeInsets.all(5),
    Function(double?)? onFieldSubmitted,
    Function(double?)? onChangedDouble,
    bool alternative = false,
    bool fullWidth = false,
    String? currency,
    bool keyboardAction = true,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          initialValue:
              controller != null ? controller.text : initialValue.toString(),
          builder: (FormFieldState<String> field) {
            final state = field as PanopticFormDecimalFieldState;
            final textFormField = _buildTextFormField(
              state,
              enabled,
              autocorrect,
              autofocus,
              readOnly,
              showCursor,
              icon,
              trailing,
              contentPadding,
              alternative,
              currency,
              onFieldSubmitted,
              onChangedDouble,
            );

            return keyboardAction
                ? KeyboardAction(
                    focusNode: FocusScope.of(state.context),
                    child: fullWidth
                        ? textFormField
                        : _buildColumn(
                            state,
                            forceColumn,
                            label,
                            hintText,
                            leadingPadding,
                            contentPadding,
                            textFormField,
                          ),
                  )
                : fullWidth
                    ? textFormField
                    : _buildColumn(
                        state,
                        forceColumn,
                        label,
                        hintText,
                        leadingPadding,
                        contentPadding,
                        textFormField,
                      );
          },
        );

  static Widget _buildColumn(
    PanopticFormDecimalFieldState state,
    bool forceColumn,
    String? label,
    String? hintText,
    EdgeInsetsGeometry leadingPadding,
    EdgeInsetsGeometry contentPadding,
    Widget textFormField,
  ) {
    return Column(
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
                        color: Theme.of(state.context)
                            .colorScheme
                            .onSurface
                            .withAlpha(100),
                      ),
                    ),
                ],
              ),
            Padding(padding: leadingPadding),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(state.context).size.width,
              ),
              width: forceColumn ? null : 400,
              child: textFormField,
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

  static Widget _buildTextFormField(
    PanopticFormDecimalFieldState state,
    bool enabled,
    bool autocorrect,
    bool autofocus,
    bool readOnly,
    bool showCursor,
    Widget? icon,
    Widget? trailing,
    EdgeInsetsGeometry contentPadding,
    bool alternative,
    String? currency,
    Function(double?)? onFieldSubmitted,
    Function(double?)? onChangedDouble,
  ) {
    return TextFormField(
      enabled: enabled,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
      ],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      autocorrect: autocorrect,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      controller: state._effectiveController,
      onChanged: (value) {
        if (value.isEmpty) {
          state.didChange(null);
        } else {
          state.didChange(value);
          onChangedDouble?.call(double.tryParse(value));
        }
      },
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted(double.tryParse(value));
        }
      },
      decoration: _buildInputDecoration(
        state,
        icon,
        trailing,
        contentPadding,
        alternative,
        currency,
      ),
    );
  }

  static InputDecoration _buildInputDecoration(
    PanopticFormDecimalFieldState state,
    Widget? icon,
    Widget? trailing,
    EdgeInsetsGeometry contentPadding,
    bool alternative,
    String? currency,
  ) {
    return InputDecoration(
      prefixIcon: icon,
      suffixIcon: trailing,
      prefixText: currency,
      fillColor: (alternative
              ? Theme.of(state.context).colorScheme.surfaceContainer
              : Theme.of(state.context).colorScheme.surface)
          .withAlpha(55),
      filled: true,
      contentPadding: contentPadding,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : Theme.of(state.context).colorScheme.onSurface,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          width: 1,
          color: state.hasError
              ? Theme.of(state.context).colorScheme.error
              : Theme.of(state.context).colorScheme.onSurface,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        borderSide: BorderSide(
          width: 1,
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
              : Theme.of(state.context).colorScheme.onSurface,
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
    );
  }

  @override
  PanopticFormFieldDecorationState<PanopticDecimalFormField, String>
      createState() => PanopticFormDecimalFieldState();
}

class PanopticFormDecimalFieldState
    extends PanopticFormFieldDecorationState<PanopticDecimalFormField, String> {
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: value);
    _controller!.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller!.removeListener(_handleControllerChanged);
    if (widget.controller == null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _effectiveController!.text = initialValue ?? '';
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController!.text != value) {
      _effectiveController!.text = value ?? '';
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != (value ?? '')) {
      didChange(_effectiveController!.text);
    }
  }
}
