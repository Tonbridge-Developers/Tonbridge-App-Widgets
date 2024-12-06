// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticTextFormField extends PanopticFormFieldDecoration<String> {
  final TextEditingController? controller;

  PanopticTextFormField({
    super.key,
    super.onSaved,
    required super.name,
    super.enabled = true,
    super.onChanged,
    this.controller,
    bool autoValidate = false,
    initialValue,
    String? label,
    String? hintText,
    String? placeholder,
    Widget? icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    bool checked = false,
    bool checkedEnabled = false,
    bool copyButton = false,
    String? Function(String?)? validator,
    int? maxLines,
    int? minLines,
    int? maxLength,
    bool isDense = false,
    double width = 400,
    bool fullWidth = false,
    bool forceColumn = false,
    int alpha = 55,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    EdgeInsetsGeometry leadingPadding = const EdgeInsets.all(5),
    Function(String)? onFieldSubmitted,
    List<String> autoFillHints = const [],
    List<TextInputFormatter> inputFormatters = const [],
    bool keyboardAction = true,
    Widget? trailing,
    bool alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          initialValue: controller?.text ?? initialValue,
          validator: checked
              ? (checkedEnabled && enabled ? validator : null)
              : enabled
                  ? validator
                  : null,
          builder: (FormFieldState<String> field) {
            final state = field as PanopticFormTextFieldState;

            return fullWidth
                ? _buildFullWidthField(
                    state,
                    icon: icon,
                    placeholder: placeholder,
                    trailing: trailing,
                    alpha: alpha,
                    alternative: alternative,
                    contentPadding: contentPadding,
                    isDense: isDense,
                    onChanged: state.didChange,
                    onFieldSubmitted: onFieldSubmitted,
                  )
                : _buildCustomField(
                    state,
                    label: label,
                    hintText: hintText,
                    placeholder: placeholder,
                    icon: icon,
                    trailing: trailing,
                    checked: checked,
                    checkedEnabled: checkedEnabled,
                    copyButton: copyButton,
                    width: width,
                    alpha: alpha,
                    contentPadding: contentPadding,
                    leadingPadding: leadingPadding,
                    alternative: alternative,
                    isDense: isDense,
                    onChanged: state.didChange,
                    onFieldSubmitted: onFieldSubmitted,
                  );
          },
        );

  // InputDecoration builder to reduce repetition
  static InputDecoration _buildInputDecoration({
    required BuildContext context,
    String? placeholder,
    Widget? icon,
    Widget? trailing,
    int alpha = 55,
    bool alternative = false,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    bool isDense = false,
    bool hasError = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: placeholder,
      prefixIcon: icon,
      suffixIcon: trailing,
      fillColor:
          (alternative ? colorScheme.surfaceContainer : colorScheme.surface)
              .withAlpha(alpha),
      filled: true,
      contentPadding: contentPadding,
      isDense: isDense,
      focusedBorder: _buildOutlineBorder(colorScheme.onSurface),
      enabledBorder: _buildOutlineBorder(colorScheme.onSurface),
      errorBorder: _buildOutlineBorder(colorScheme.error),
      focusedErrorBorder: _buildOutlineBorder(colorScheme.error),
    );
  }

  // Common border style for InputDecoration
  static OutlineInputBorder _buildOutlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  // Full-width field builder
  static Widget _buildFullWidthField(
    PanopticFormTextFieldState state, {
    required Widget? icon,
    required String? placeholder,
    required Widget? trailing,
    required int alpha,
    required bool alternative,
    required EdgeInsetsGeometry contentPadding,
    required bool isDense,
    required Function(String)? onChanged,
    required Function(String)? onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    int? maxLines,
    int? minLines,
    int? maxLength,
  }) {
    return TextFormField(
      enabled: state.widget.enabled,
      controller: state._effectiveController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: _buildInputDecoration(
        context: state.context,
        placeholder: placeholder,
        icon: icon,
        trailing: trailing,
        alpha: alpha,
        alternative: alternative,
        contentPadding: contentPadding,
        isDense: isDense,
      ),
    );
  }

  // Custom field builder for additional configurations
  static Widget _buildCustomField(
    PanopticFormTextFieldState state, {
    required String? label,
    required String? hintText,
    required String? placeholder,
    required Widget? icon,
    required Widget? trailing,
    required bool checked,
    required bool checkedEnabled,
    required bool copyButton,
    required double width,
    required int alpha,
    required EdgeInsetsGeometry contentPadding,
    required EdgeInsetsGeometry leadingPadding,
    required bool alternative,
    required bool isDense,
    required Function(String)? onChanged,
    required Function(String)? onFieldSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Text(label, style: Theme.of(state.context).textTheme.bodyLarge),
        Padding(padding: leadingPadding),
        if (checked)
          _buildCheckedField(
            state,
            icon: icon,
            trailing: trailing,
            placeholder: placeholder,
            checkedEnabled: checkedEnabled,
            width: width,
            alpha: alpha,
            contentPadding: contentPadding,
            isDense: isDense,
            alternative: alternative,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
          )
        else if (copyButton)
          _buildCopyableField(
            state,
            icon: icon,
            trailing: trailing,
            placeholder: placeholder,
            width: width,
            alpha: alpha,
            contentPadding: contentPadding,
            isDense: isDense,
            alternative: alternative,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
          )
        else
          _buildDefaultField(
            state,
            icon: icon,
            trailing: trailing,
            placeholder: placeholder,
            width: width,
            alpha: alpha,
            contentPadding: contentPadding,
            isDense: isDense,
            alternative: alternative,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
          ),
      ],
    );
  }

  // Checked field builder
  static Widget _buildCheckedField(
    PanopticFormTextFieldState state, {
    required Widget? icon,
    required Widget? trailing,
    required String? placeholder,
    required bool checkedEnabled,
    required double width,
    required int alpha,
    required EdgeInsetsGeometry contentPadding,
    required bool isDense,
    required bool alternative,
    required Function(String)? onChanged,
    required Function(String)? onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    int? maxLines,
    int? minLines,
    int? maxLength,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: checkedEnabled && state.widget.enabled,
            controller: state._effectiveController,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            autofocus: autofocus,
            readOnly: readOnly,
            showCursor: showCursor,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            decoration: _buildInputDecoration(
              context: state.context,
              placeholder: placeholder,
              icon: icon,
              trailing: trailing,
              alpha: alpha,
              alternative: alternative,
              contentPadding: contentPadding,
              isDense: isDense,
            ),
          ),
        ),
        const SizedBox(width: 10),
        !checkedEnabled
            ? PanopticIconButton(
                icon: PanopticIcons.edit,
                size: 50,
                isDisabled: !state.widget.enabled,
                onTap: () {
                  state.setState(() {
                    checkedEnabled = true;
                  });
                },
              )
            : PanopticIconButton(
                icon: PanopticIcons.undo,
                size: 50,
                isDisabled: !state.widget.enabled,
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

  // Copyable field builder
  static Widget _buildCopyableField(
    PanopticFormTextFieldState state, {
    required Widget? icon,
    required Widget? trailing,
    required String? placeholder,
    required double width,
    required int alpha,
    required EdgeInsetsGeometry contentPadding,
    required bool isDense,
    required bool alternative,
    required Function(String)? onChanged,
    required Function(String)? onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    int? maxLines,
    int? minLines,
    int? maxLength,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: state.widget.enabled,
            controller: state._effectiveController,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            autofocus: autofocus,
            readOnly: readOnly,
            showCursor: showCursor,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            decoration: _buildInputDecoration(
              context: state.context,
              placeholder: placeholder,
              icon: icon,
              trailing: trailing,
              alpha: alpha,
              alternative: alternative,
              contentPadding: contentPadding,
              isDense: isDense,
            ),
          ),
        ),
        const SizedBox(width: 10),
        PanopticIconButton(
          icon: PanopticIcons.copy,
          size: 50,
          isDisabled: state.widget.enabled,
          onTap: () {
            state.setState(() async {
              await Clipboard.setData(
                  ClipboardData(text: state._effectiveController!.text));
              PanopticExtension.showToast('Copied to Clipboard!', state.context,
                  type: ToastType.success);
            });
          },
        ),
      ],
    );
  }

  // Default field builder
  static Widget _buildDefaultField(
    PanopticFormTextFieldState state, {
    required Widget? icon,
    required Widget? trailing,
    required String? placeholder,
    required double width,
    required int alpha,
    required EdgeInsetsGeometry contentPadding,
    required bool isDense,
    required bool alternative,
    required Function(String)? onChanged,
    required Function(String)? onFieldSubmitted,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    int? maxLines,
    int? minLines,
    int? maxLength,
  }) {
    return TextFormField(
      enabled: state.widget.enabled,
      controller: state._effectiveController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: _buildInputDecoration(
        context: state.context,
        placeholder: placeholder,
        icon: icon,
        trailing: trailing,
        alpha: alpha,
        alternative: alternative,
        contentPadding: contentPadding,
        isDense: isDense,
      ),
    );
  }

  @override
  PanopticFormFieldDecorationState<PanopticTextFormField, String>
      createState() => PanopticFormTextFieldState();
}

class PanopticFormTextFieldState
    extends PanopticFormFieldDecorationState<PanopticTextFormField, String> {
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
    _controller?.removeListener(_handleControllerChanged);
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController?.text = initialValue ?? '';
    });
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController?.text != value) {
      _effectiveController?.text = value ?? '';
    }
    setState(() {});
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != (value ?? '')) {
      didChange(_effectiveController?.text);
    }
  }
}
