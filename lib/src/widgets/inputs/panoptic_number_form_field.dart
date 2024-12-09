import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticNumberFormField extends PanopticFormFieldDecoration<int> {
  final TextEditingController? controller;

  PanopticNumberFormField({
    super.key,
    super.onSaved,
    super.validator,
    int? initialValue,
    required super.name,
    super.onChanged,
    super.enabled = true,
    bool autoValidate = false,
    this.controller,
    String? label,
    bool forceColumn = false,
    String? hintText,
    Widget? icon,
    bool autocorrect = true,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor = true,
    Widget? trailing,
    bool alternative = false,
    bool fullWidth = false,
    bool keyboardAction = true,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          initialValue:
              controller != null ? int.tryParse(controller.text) : initialValue,
          builder: (FormFieldState<int> field) {
            final state = field as PanopticFormNumberFieldState;

            Widget buildTextFormField() {
              return TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enabled: enabled,
                keyboardType: TextInputType.number,
                autocorrect: autocorrect,
                autofocus: autofocus,
                controller: state._effectiveController,
                readOnly: readOnly,
                showCursor: showCursor,
                onChanged: (value) {
                  if (value.isEmpty) {
                    state.didChange(null);
                  } else {
                    state.didChange(int.tryParse(value));
                  }
                  onChanged?.call(state.value);
                },
                decoration: InputDecoration(
                  prefixIcon: icon,
                  suffixIcon: trailing,
                  fillColor: (alternative
                          ? Theme.of(state.context).colorScheme.surfaceContainer
                          : Theme.of(state.context).colorScheme.surface)
                      .withAlpha(255),
                  filled: true,
                  contentPadding: const EdgeInsets.all(17),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(
                        color: state.hasError
                            ? Theme.of(state.context).colorScheme.error
                            : Theme.of(state.context).colorScheme.onSurface),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(
                      width: 1,
                      color: state.hasError
                          ? Theme.of(state.context).colorScheme.error
                          : Theme.of(state.context).colorScheme.onSurface,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(
                      width: 1,
                      color: state.hasError
                          ? Theme.of(state.context).colorScheme.error
                          : Theme.of(state.context).colorScheme.onSurface,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(
                        color: state.hasError
                            ? Theme.of(state.context).colorScheme.error
                            : Theme.of(state.context).colorScheme.onSurface),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    borderSide: BorderSide(
                      width: 1,
                      color: state.hasError
                          ? Theme.of(state.context).colorScheme.error
                          : Theme.of(state.context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }

            return keyboardAction
                ? KeyboardAction(
                    focusNode: FocusScope.of(state.context),
                    child: fullWidth
                        ? buildTextFormField()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PanopticResponsiveLayout(
                                forceColumn: forceColumn,
                                childrenPadding: const EdgeInsets.all(2),
                                rowCrossAxisAlignment:
                                    CrossAxisAlignment.center,
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
                                        if (hintText != null)
                                          Tooltip(
                                            message: hintText,
                                            preferBelow: true,
                                            verticalOffset: 10,
                                            triggerMode: kIsWeb
                                                ? null
                                                : TooltipTriggerMode.tap,
                                            child: PanopticIcon(
                                              icon: PanopticIcons.infoRound,
                                              size: 15,
                                              margin: const EdgeInsets.only(
                                                  left: 5, top: 2),
                                              color: Theme.of(state.context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withAlpha(100),
                                            ),
                                          ),
                                      ],
                                    ),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(state.context)
                                          .size
                                          .width,
                                    ),
                                    width: forceColumn ? null : 400,
                                    child: buildTextFormField(),
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
                                          .copyWith(
                                              color: Theme.of(state.context)
                                                  .colorScheme
                                                  .error),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                  )
                : fullWidth
                    ? buildTextFormField()
                    : Column(
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
                                    if (hintText != null)
                                      Tooltip(
                                        message: hintText,
                                        preferBelow: true,
                                        verticalOffset: 10,
                                        triggerMode: kIsWeb
                                            ? null
                                            : TooltipTriggerMode.tap,
                                        child: PanopticIcon(
                                          icon: PanopticIcons.infoRound,
                                          size: 15,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 2),
                                          color: Theme.of(state.context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(100),
                                        ),
                                      ),
                                  ],
                                ),
                              const Padding(padding: EdgeInsets.all(5)),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(state.context).size.width,
                                ),
                                width: forceColumn ? null : 400,
                                child: buildTextFormField(),
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
                                      .copyWith(
                                          color: Theme.of(state.context)
                                              .colorScheme
                                              .error),
                                ),
                              ],
                            ),
                        ],
                      );
          },
        );

  @override
  PanopticFormFieldDecorationState<PanopticNumberFormField, int>
      createState() => PanopticFormNumberFieldState();
}

class PanopticFormNumberFieldState
    extends PanopticFormFieldDecorationState<PanopticNumberFormField, int> {
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: value?.toString());
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
    setState(() {
      _effectiveController!.text = initialValue?.toString() ?? '';
    });
  }

  @override
  void didChange(int? value) {
    super.didChange(value);
    if (_effectiveController!.text != value?.toString()) {
      _effectiveController!.text = value?.toString() ?? '';
    }
    setState(() {});
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != (value?.toString() ?? '')) {
      didChange(int.tryParse(_effectiveController!.text));
    }
  }
}
