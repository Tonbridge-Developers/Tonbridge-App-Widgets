// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticTextFormField extends PanopticFormFieldDecoration<String> {
  final bool checkedEnabled;
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
    this.checkedEnabled = false,
    bool copyButton = false,
    String? Function(String?)? validator,
    int? maxLines,
    int? minLines,
    int? maxLength,
    int? maxCharacters,
    int? minCharacters,
    bool isDense = false,
    double width = 400,
    bool fullWidth = false,
    bool forceColumn = false,
    int alpha = 255,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(17),
    EdgeInsetsGeometry leadingPadding = const EdgeInsets.all(5),
    Function(String)? onFieldSubmitted,
    List<String> autoFillHints = const [],
    List<TextInputFormatter> inputFormatters = const [],
    Widget? trailing,
    bool keyboardActions = true,
    //Use the alternative bg color
    alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          initialValue: controller != null ? controller.text : initialValue,
          validator: checked
              ? (checkedEnabled && enabled ? validator : null)
              : enabled
                  ? validator
                  : null,
          builder: (FormFieldState<String> field) {
            final state = field as PanopticFormTextFieldState;

            if (keyboardActions) {
              return KeyboardAction(
                focusNode: FocusScope.of(state.context),
                child: _buildField(
                  state,
                  checkedEnabled,
                  enabled,
                  placeholder,
                  icon,
                  trailing,
                  obscureText,
                  keyboardType,
                  autocorrect,
                  autofocus,
                  readOnly,
                  showCursor,
                  maxLines,
                  minLines,
                  maxLength,
                  isDense,
                  alpha,
                  contentPadding,
                  onChanged,
                  onFieldSubmitted,
                  alternative,
                  fullWidth,
                  forceColumn,
                  label,
                  hintText,
                  leadingPadding,
                  width,
                  checked,
                  copyButton,
                  initialValue,
                ),
              );
            } else {
              return _buildField(
                state,
                checkedEnabled,
                enabled,
                placeholder,
                icon,
                trailing,
                obscureText,
                keyboardType,
                autocorrect,
                autofocus,
                readOnly,
                showCursor,
                maxLines,
                minLines,
                maxLength,
                isDense,
                alpha,
                contentPadding,
                onChanged,
                onFieldSubmitted,
                alternative,
                fullWidth,
                forceColumn,
                label,
                hintText,
                leadingPadding,
                width,
                checked,
                copyButton,
                initialValue,
              );
            }
          },
        );

  static Widget _buildField(
    PanopticFormTextFieldState state,
    bool checkedEnabled,
    bool enabled,
    String? placeholder,
    Widget? icon,
    Widget? trailing,
    bool obscureText,
    TextInputType keyboardType,
    bool autocorrect,
    bool autofocus,
    bool readOnly,
    bool showCursor,
    int? maxLines,
    int? minLines,
    int? maxLength,
    bool isDense,
    int alpha,
    EdgeInsetsGeometry contentPadding,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
    bool alternative,
    bool fullWidth,
    bool forceColumn,
    String? label,
    String? hintText,
    EdgeInsetsGeometry leadingPadding,
    double width,
    bool checked,
    bool copyButton,
    String? initialValue,
  ) {
    if (fullWidth) {
      return _buildTextField(
        state,
        checkedEnabled,
        enabled,
        placeholder,
        icon,
        trailing,
        obscureText,
        keyboardType,
        autocorrect,
        autofocus,
        readOnly,
        showCursor,
        maxLines,
        minLines,
        maxLength,
        isDense,
        alpha,
        contentPadding,
        onChanged,
        onFieldSubmitted,
        alternative,
      );
    } else {
      return _buildStandardField(
        state,
        checkedEnabled,
        enabled,
        placeholder,
        icon,
        trailing,
        obscureText,
        keyboardType,
        autocorrect,
        autofocus,
        readOnly,
        showCursor,
        maxLines,
        minLines,
        maxLength,
        isDense,
        alpha,
        contentPadding,
        onChanged,
        onFieldSubmitted,
        alternative,
        forceColumn,
        label,
        hintText,
        leadingPadding,
        width,
        checked,
        copyButton,
        initialValue,
      );
    }
  }

  static Widget _buildStandardField(
    PanopticFormTextFieldState state,
    bool checkedEnabled,
    bool enabled,
    String? placeholder,
    Widget? icon,
    Widget? trailing,
    bool obscureText,
    TextInputType keyboardType,
    bool autocorrect,
    bool autofocus,
    bool readOnly,
    bool showCursor,
    int? maxLines,
    int? minLines,
    int? maxLength,
    bool isDense,
    int alpha,
    EdgeInsetsGeometry contentPadding,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
    bool alternative,
    bool forceColumn,
    String? label,
    String? hintText,
    EdgeInsetsGeometry leadingPadding,
    double width,
    bool checked,
    bool copyButton,
    String? initialValue,
  ) {
    return Column(
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
                  if (hintText != null) ...{
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
                    )
                  }
                ],
              ),
            Padding(padding: leadingPadding),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(state.context).size.width,
              ),
              width: forceColumn ? null : width,
              child: Row(
                children: [
                  PanopticExpanded(
                    expandOnDesktop: checked || copyButton,
                    expandOnMobile: checked || copyButton,
                    flex: 4,
                    child: _buildTextField(
                      state,
                      checkedEnabled,
                      enabled,
                      placeholder,
                      icon,
                      trailing,
                      obscureText,
                      keyboardType,
                      autocorrect,
                      autofocus,
                      readOnly,
                      showCursor,
                      maxLines,
                      minLines,
                      maxLength,
                      isDense,
                      alpha,
                      contentPadding,
                      onChanged,
                      onFieldSubmitted,
                      alternative,
                    ),
                  ),
                  if (copyButton) ...{
                    const SizedBox(width: 10),
                    PanopticIconButton(
                      icon: PanopticIcons.copy,
                      size: 50,
                      isDisabled: !enabled,
                      onTap: () {
                        state.setState(() async {
                          await Clipboard.setData(ClipboardData(
                              text: state._effectiveController!.text));
                          PanopticExtension.showToast(
                              'Copied to Clipboard!', state.context,
                              type: ToastType.success);
                        });
                      },
                    ),
                  },
                  if (checked) ...{
                    const SizedBox(width: 10),
                    if (checkedEnabled) ...{
                      PanopticIconButton(
                        icon: PanopticIcons.edit,
                        size: 50,
                        isDisabled: !enabled,
                        onTap: () {
                          state.setState(() {
                            checkedEnabled = true;
                            state.checkedEnabledNotifier.value = true;
                          });
                        },
                      )
                    } else ...{
                      PanopticIconButton(
                        icon: PanopticIcons.undo,
                        size: 50,
                        isDisabled: !enabled,
                        onTap: () {
                          state.setState(() {
                            checkedEnabled = false;
                            state.checkedEnabledNotifier.value = false;
                            state.didChange(initialValue);
                          });
                        },
                      ),
                    },
                  }
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  static Widget _buildTextField(
    PanopticFormTextFieldState state,
    bool checkedEnabled,
    bool enabled,
    String? placeholder,
    Widget? icon,
    Widget? trailing,
    bool obscureText,
    TextInputType keyboardType,
    bool autocorrect,
    bool autofocus,
    bool readOnly,
    bool showCursor,
    int? maxLines,
    int? minLines,
    int? maxLength,
    bool isDense,
    int alpha,
    EdgeInsetsGeometry contentPadding,
    Function(String)? onChanged,
    Function(String)? onFieldSubmitted,
    bool alternative,
  ) {
    return TextFormField(
      enabled: checkedEnabled && enabled,
      scribbleEnabled: true,
      obscureText: obscureText,
      controller: state._effectiveController,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: (value) {
        onChanged?.call(value);
        state.didChange(value);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
      },
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: icon,
        suffixIcon: trailing,
        fillColor: (alternative
                ? Theme.of(state.context).colorScheme.surfaceContainer
                : Theme.of(state.context).colorScheme.surface)
            .withAlpha(alpha),
        filled: true,
        contentPadding: contentPadding,
        isDense: isDense,
        focusedErrorBorder: _border(state),
        focusedBorder: _border(state),
        enabledBorder: _border(state),
        errorBorder: _border(state),
        border: _border(state),
      ),
    );
  }

  static OutlineInputBorder _border(PanopticFormTextFieldState state) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
      borderSide: BorderSide(
        width: 1,
        color: state.hasError
            ? Theme.of(state.context).colorScheme.error
            : Theme.of(state.context).colorScheme.onSurface,
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

  late ValueNotifier<bool> checkedEnabledNotifier;

  @override
  void initState() {
    super.initState();
    //setting this to value instead of initialValue here is OK since we handle initial value in the parent class
    _controller = widget.controller ?? TextEditingController(text: value);
    _controller!.addListener(_handleControllerChanged);
    checkedEnabledNotifier = ValueNotifier(widget.checkedEnabled);
  }

  @override
  void dispose() {
    // Dispose the _controller when initState created it
    _controller!.removeListener(_handleControllerChanged);
    if (null == widget.controller) {
      _controller!.dispose();
    }
    checkedEnabledNotifier.dispose();
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = initialValue ?? '';
    });
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController!.text != value) {
      _effectiveController!.text = value ?? '';
    }
    setState(() {});
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController!.text != (value ?? '')) {
      didChange(_effectiveController!.text);
    }
  }
}
