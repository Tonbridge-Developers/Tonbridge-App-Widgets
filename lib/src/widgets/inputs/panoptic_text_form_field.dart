// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/actions/keyboard_action/keyboard_action.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

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
    int? maxCharacters,
    int? minCharacters,
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

            return KeyboardAction(
              focusNode: FocusScope.of(state.context),
              child: fullWidth
                  ?
                  // #region full width
                  TextFormField(
                      enabled: enabled,
                      autofillHints: autoFillHints,
                      inputFormatters: inputFormatters,
                      scribbleEnabled: true,
                      obscureText: obscureText,
                      keyboardType: keyboardType,
                      autocorrect: autocorrect,
                      autofocus: autofocus,
                      controller: state._effectiveController,
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
                        prefixIcon: icon,
                        hintText: placeholder,
                        fillColor: (alternative
                                ? Theme.of(state.context)
                                    .colorScheme
                                    .surfaceContainer
                                : Theme.of(state.context).colorScheme.surface)
                            .withAlpha(alpha),
                        filled: true,
                        contentPadding: contentPadding,
                        isDense: isDense,
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              CoreValues.cornerRadius * 0.8),
                          borderSide: BorderSide(
                              color: state.hasError
                                  ? Theme.of(state.context).colorScheme.error
                                  : Theme.of(state.context)
                                      .colorScheme
                                      .onSurface),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              CoreValues.cornerRadius * 0.8),
                          borderSide: BorderSide(
                            width: 1,
                            color: state.hasError
                                ? Theme.of(state.context).colorScheme.error
                                : Theme.of(state.context).colorScheme.onSurface,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              CoreValues.cornerRadius * 0.8),
                          borderSide: BorderSide(
                              color: state.hasError
                                  ? Theme.of(state.context).colorScheme.error
                                  : Theme.of(state.context)
                                      .colorScheme
                                      .onSurface),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              CoreValues.cornerRadius * 0.8),
                          borderSide: BorderSide(
                            width: 1,
                            color: state.hasError
                                ? Theme.of(state.context).colorScheme.error
                                : Theme.of(state.context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    )
                  // #endregion
                  :
                  // #region not full width
                  Column(
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
                                    style: Theme.of(state.context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                  if (hintText != null) ...{
                                    Tooltip(
                                      message: hintText,
                                      preferBelow: true,
                                      verticalOffset: 10,
                                      triggerMode: kIsWeb
                                          ? null
                                          : TooltipTriggerMode.tap,
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
                            Padding(padding: leadingPadding),
                            if (checked) ...{
                              //If checked
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(state.context).size.width,
                                ),
                                width: forceColumn ? null : width,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: TextFormField(
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
                                          fillColor: (alternative
                                                  ? Theme.of(state.context)
                                                      .colorScheme
                                                      .surfaceContainer
                                                  : Theme.of(state.context)
                                                      .colorScheme
                                                      .surface)
                                              .withAlpha(alpha),
                                          filled: true,
                                          contentPadding: contentPadding,
                                          isDense: isDense,
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                CoreValues.cornerRadius * 0.8),
                                            borderSide: BorderSide(
                                                color: state.hasError
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .error
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .onSurface),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                CoreValues.cornerRadius * 0.8),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: state.hasError
                                                  ? Theme.of(state.context)
                                                      .colorScheme
                                                      .error
                                                  : Theme.of(state.context)
                                                      .colorScheme
                                                      .onSurface,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                CoreValues.cornerRadius * 0.8),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: state.hasError
                                                  ? Theme.of(state.context)
                                                      .colorScheme
                                                      .error
                                                  : Theme.of(state.context)
                                                      .colorScheme
                                                      .onSurface,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                CoreValues.cornerRadius * 0.8),
                                            borderSide: BorderSide(
                                                color: state.hasError
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .error
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .onSurface),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                CoreValues.cornerRadius * 0.8),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: state.hasError
                                                  ? Theme.of(state.context)
                                                      .colorScheme
                                                      .error
                                                  : Theme.of(state.context)
                                                      .colorScheme
                                                      .onSurface,
                                            ),
                                          ),
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
                                            icon: CoreIcons.undo,
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
                                ),
                              ),
                            } else ...{
                              if (copyButton) ...{
                                //Not checked but copyable
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(state.context).size.width,
                                  ),
                                  width: forceColumn ? null : width,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          enabled: enabled,
                                          scribbleEnabled: true,
                                          obscureText: obscureText,
                                          controller:
                                              state._effectiveController,
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
                                            fillColor: (alternative
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .surfaceContainer
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .surface)
                                                .withAlpha(alpha),
                                            filled: true,
                                            contentPadding: contentPadding,
                                            isDense: isDense,
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                              borderSide: BorderSide(
                                                  color: state.hasError
                                                      ? Theme.of(state.context)
                                                          .colorScheme
                                                          .error
                                                      : Theme.of(state.context)
                                                          .colorScheme
                                                          .onSurface),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: state.hasError
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .error
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .onSurface,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: state.hasError
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .error
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .onSurface,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                              borderSide: BorderSide(
                                                  color: state.hasError
                                                      ? Theme.of(state.context)
                                                          .colorScheme
                                                          .error
                                                      : Theme.of(state.context)
                                                          .colorScheme
                                                          .onSurface),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      CoreValues.cornerRadius *
                                                          0.8),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: state.hasError
                                                    ? Theme.of(state.context)
                                                        .colorScheme
                                                        .error
                                                    : Theme.of(state.context)
                                                        .colorScheme
                                                        .onSurface,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      PanopticIconButton(
                                        icon: CoreIcons.copy,
                                        size: 50,
                                        isDisabled: !enabled,
                                        onTap: () {
                                          state.setState(() async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: state
                                                        ._effectiveController!
                                                        .text));
                                            PanopticExtension.showToast(
                                                'Copied to Clipboard!',
                                                state.context,
                                                type: ToastType.success);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              } else ...{
                                //Not copyable or checked
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(state.context).size.width,
                                  ),
                                  width: forceColumn ? null : width,
                                  child: TextFormField(
                                    //If checked == false
                                    enabled: enabled,
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
                                      //onChanged?.call(value);
                                      state.didChange(value);
                                    },
                                    onFieldSubmitted: (value) {
                                      onFieldSubmitted?.call(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: placeholder,
                                      prefixIcon: icon,
                                      fillColor: (alternative
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .surfaceContainer
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .surface)
                                          .withAlpha(alpha),
                                      filled: true,
                                      contentPadding: contentPadding,
                                      isDense: isDense,
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                            color: state.hasError
                                                ? Theme.of(state.context)
                                                    .colorScheme
                                                    .error
                                                : Theme.of(state.context)
                                                    .colorScheme
                                                    .onSurface),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: state.hasError
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: state.hasError
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                            color: state.hasError
                                                ? Theme.of(state.context)
                                                    .colorScheme
                                                    .error
                                                : Theme.of(state.context)
                                                    .colorScheme
                                                    .onSurface),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: state.hasError
                                              ? Theme.of(state.context)
                                                  .colorScheme
                                                  .error
                                              : Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              }
                            }
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
                                    .copyWith(
                                        color: Theme.of(state.context)
                                            .colorScheme
                                            .error),
                              )
                            ],
                          )
                      ],
                    ),
            );
            // #endregion
          },
        );

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
    //setting this to value instead of initialValue here is OK since we handle initial value in the parent class
    _controller = widget.controller ?? TextEditingController(text: value);
    _controller!.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    // Dispose the _controller when initState created it
    _controller!.removeListener(_handleControllerChanged);
    if (null == widget.controller) {
      _controller!.dispose();
    }
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
