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
    initialValue,
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

    //Use the alternative bg color
    alternative = false,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          initialValue: initialValue,
          builder: (FormFieldState<Color> field) {
            final state = field as PanopticColourPickerFormFieldState;

            return KeyboardAction(
              focusNode: FocusScope.of(state.context),
              child: fullWidth
                  ?
                  // #region full width
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 47,
                            decoration: BoxDecoration(
                              color: state.value,
                              borderRadius: BorderRadius.circular(
                                  CoreValues.cornerRadius * 0.8),
                            ),
                            child: Center(
                              child: Text(
                                  '#${(state.value ?? Colors.white).toHexString().substring(2)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: Theme.of(state.context)
                                          .textTheme
                                          .bodyLarge!
                                          .fontStyle,
                                      color:
                                          state.value!.computeLuminance() > 0.5
                                              ? Colors.black
                                              : Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        PanopticIconButton(
                          icon: CoreIcons.paint,
                          size: 50,
                          onTap: () {
                            showDialog(
                                context: state.context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Select a colour:'),
                                    content: SingleChildScrollView(
                                        child: HueRingPicker(
                                      pickerColor: initialValue! ??
                                          Theme.of(state.context)
                                              .colorScheme
                                              .primary,
                                      portraitOnly: true,
                                      onColorChanged: state.didChange,
                                      enableAlpha: false,
                                      displayThumbColor: true,
                                    )),
                                    actions: <Widget>[
                                      PanopticButton(
                                        label: 'Done',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
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
                                    child: Container(
                                      height: 47,
                                      decoration: BoxDecoration(
                                        color: state.value,
                                        borderRadius: BorderRadius.circular(
                                            CoreValues.cornerRadius * 0.8),
                                      ),
                                      child: Center(
                                        child: Text(
                                            '#${(state.value ?? Colors.white).toHexString().substring(2)}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontStyle:
                                                    Theme.of(state.context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .fontStyle,
                                                color: state.value!
                                                            .computeLuminance() >
                                                        0.5
                                                    ? Colors.black
                                                    : Colors.white)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  PanopticIconButton(
                                    icon: CoreIcons.paint,
                                    size: 50,
                                    onTap: () {
                                      showDialog(
                                          context: state.context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Select a colour:'),
                                              content: SingleChildScrollView(
                                                  child: HueRingPicker(
                                                pickerColor: initialValue! ??
                                                    Theme.of(state.context)
                                                        .colorScheme
                                                        .primary,
                                                portraitOnly: true,
                                                onColorChanged: state.didChange,
                                                enableAlpha: false,
                                                displayThumbColor: true,
                                              )),
                                              actions: <Widget>[
                                                PanopticButton(
                                                  label: 'Done',
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
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
