import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_base_file.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/form/panoptic_form_decoration.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_responsive_layout.dart';

class PanopticFileUploadFormField
    extends PanopticFormFieldDecoration<List<CoreBaseFile>> {
  PanopticFileUploadFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required super.name,
    super.enabled,
    super.onChanged,
    bool forceColumn = false,
    bool autoValidate = false,
    List<String>? allowedExtensions,
    String uploadedBy = 'Form',
    String? hintText,
    //Use the alternative bg color
    alternative = false,
    bool fullWidth = false,
    String? label,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<CoreBaseFile>> field) {
            final state = field as PanopticFileUploadFormFieldState;
            return fullWidth
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PanopticButton(
                        isDisabled: !enabled,
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  allowMultiple: true,
                                  withData: true,
                                  allowedExtensions: allowedExtensions,
                                  type: allowedExtensions == null
                                      ? FileType.any
                                      : FileType.custom);

                          if (result != null) {
                            for (var file in result.files) {
                              state.didChange([
                                ...state.value!,
                                CoreBaseFile(
                                    id: 0,
                                    uploadedBy: uploadedBy,
                                    documentName: file.name,
                                    contentType:
                                        CoreBaseFile.convertExtensionToMimeType(
                                            file.extension!),
                                    content: file.bytes,
                                    uploadedDate: DateTime.now())
                              ]);

                              if (onChanged != null) {
                                onChanged(state.value!);
                              }
                            }
                          } else {
                            // User canceled the picker
                          }
                        },
                        label: "Upload Files",
                        icon: CoreIcons.upload,
                        buttonType: ButtonType.bordered,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        alignment: WrapAlignment.end,
                        children: [
                          if (state.value != null &&
                              state.value?.isNotEmpty == true) ...{
                            for (var file in state.value!)
                              PanopticChip(
                                margin: const EdgeInsets.all(5),
                                label: file.documentName!,
                                onDelete: () => state.didChange(state.value!
                                    .where((element) => element != file)
                                    .toList()),
                              )
                          }
                        ],
                      )
                    ],
                  )
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
                                if (hintText != null) ...{
                                  Tooltip(
                                    message: hintText,
                                    preferBelow: true,
                                    verticalOffset: 10,
                                    triggerMode:
                                        kIsWeb ? null : TooltipTriggerMode.tap,
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
                          const Padding(padding: EdgeInsets.all(5)),
                          Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(state.context).size.width,
                                ),
                                width: forceColumn ? null : 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        CoreValues.cornerRadius * 0.8),
                                    color: (alternative
                                            ? Theme.of(state.context)
                                                .colorScheme
                                                .surfaceContainer
                                            : Theme.of(state.context)
                                                .colorScheme
                                                .surface)
                                        .withAlpha(55)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    PanopticButton(
                                      isDisabled: !enabled,
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                allowMultiple: true,
                                                withData: true,
                                                allowedExtensions:
                                                    allowedExtensions,
                                                type: allowedExtensions == null
                                                    ? FileType.any
                                                    : FileType.custom);

                                        if (result != null) {
                                          for (var file in result.files) {
                                            state.didChange([
                                              ...state.value!,
                                              CoreBaseFile(
                                                  id: 0,
                                                  uploadedBy: uploadedBy,
                                                  documentName: file.name,
                                                  contentType: CoreBaseFile
                                                      .convertExtensionToMimeType(
                                                          file.extension!),
                                                  content: file.bytes,
                                                  uploadedDate: DateTime.now())
                                            ]);

                                            if (onChanged != null) {
                                              onChanged(state.value!);
                                            }
                                          }
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      label: "Upload Files",
                                      icon: CoreIcons.upload,
                                      buttonType: ButtonType.bordered,
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      alignment: WrapAlignment.end,
                                      children: [
                                        if (state.value != null &&
                                            state.value?.isNotEmpty ==
                                                true) ...{
                                          for (var file in state.value!)
                                            PanopticChip(
                                              margin: const EdgeInsets.all(5),
                                              label: file.documentName!,
                                              onDelete: () => state.didChange(
                                                  state.value!
                                                      .where((element) =>
                                                          element != file)
                                                      .toList()),
                                            )
                                        }
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      state.hasError
                          ? Row(
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
                          : Container()
                    ],
                  );
          },
        );
  @override
  PanopticFormFieldDecorationState<PanopticFileUploadFormField,
      List<CoreBaseFile>> createState() => PanopticFileUploadFormFieldState();
}

class PanopticFileUploadFormFieldState extends PanopticFormFieldDecorationState<
    PanopticFileUploadFormField, List<CoreBaseFile>> {}
