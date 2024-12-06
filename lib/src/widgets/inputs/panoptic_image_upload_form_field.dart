import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticImageUploadFormField
    extends PanopticFormFieldDecoration<List<CoreBaseFile>> {
  PanopticImageUploadFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required super.name,
    super.enabled,
    super.onChanged,
    bool forceColumn = false,
    bool autoValidate = false,
    bool multipleUploads = true,
    String? hintText,
    alternative = false,
    bool fullWidth = false,
    String? label,
  }) : super(
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          builder: (FormFieldState<List<CoreBaseFile>> field) {
            final state = field as PanopticImageUploadFormFieldState;
            return fullWidth
                ? _buildFullWidthLayout(
                    state, enabled, multipleUploads, onChanged)
                : _buildResponsiveLayout(state, forceColumn, enabled,
                    multipleUploads, onChanged, hintText, alternative, label);
          },
        );

  static Widget _buildFullWidthLayout(
      PanopticImageUploadFormFieldState state,
      bool enabled,
      bool multipleUploads,
      ValueChanged<List<CoreBaseFile>>? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildUploadButton(state, enabled, multipleUploads, onChanged),
        _buildImagePreview(state, enabled, onChanged),
      ],
    );
  }

  static Widget _buildResponsiveLayout(
      PanopticImageUploadFormFieldState state,
      bool forceColumn,
      bool enabled,
      bool multipleUploads,
      ValueChanged<List<CoreBaseFile>>? onChanged,
      String? hintText,
      bool alternative,
      String? label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PanopticResponsiveLayout(
          forceColumn: forceColumn,
          childrenPadding: const EdgeInsets.all(2),
          rowCrossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label != null) _buildLabelWithHint(state, label, hintText),
            const Padding(padding: EdgeInsets.all(5)),
            Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(state.context).size.width,
                  ),
                  width: forceColumn ? null : 400,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                    color: (alternative
                            ? Theme.of(state.context)
                                .colorScheme
                                .surfaceContainer
                            : Theme.of(state.context).colorScheme.surface)
                        .withAlpha(55),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildUploadButton(
                          state, enabled, multipleUploads, onChanged),
                      _buildImagePreview(state, enabled, onChanged),
                    ],
                  ),
                ),
              ],
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

  static Widget _buildUploadButton(
      PanopticImageUploadFormFieldState state,
      bool enabled,
      bool multipleUploads,
      ValueChanged<List<CoreBaseFile>>? onChanged) {
    return PanopticButton(
      isDisabled: !enabled,
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: multipleUploads,
          withData: true,
          type: FileType.image,
        );

        if (result != null) {
          for (var file in result.files) {
            CoreBaseFile tempFile = CoreBaseFile(
              documentName: file.name,
              contentType:
                  CoreBaseFile.convertExtensionToMimeType(file.extension!),
              content: file.bytes,
              uploadedDate: DateTime.now(),
            );

            state.didChange([...state.value!, tempFile]);

            if (onChanged != null) {
              onChanged(state.value!);
            }
          }
        }
      },
      label: "Upload Image",
      icon: PanopticIcons.upload,
      buttonType: ButtonType.bordered,
    );
  }

  static Widget _buildImagePreview(PanopticImageUploadFormFieldState state,
      bool enabled, ValueChanged<List<CoreBaseFile>>? onChanged) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        if (state.value != null && state.value?.isNotEmpty == true)
          for (var file in state.value!)
            Column(
              children: [
                PanopticCard(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  mainAxisAlignment: MainAxisAlignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(CoreValues.cornerRadius),
                          image: DecorationImage(
                            image:
                                MemoryImage(Uint8List.fromList(file.content!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          PanopticHtmlView(html: file.documentName!),
                        ],
                      ),
                    ],
                  ),
                ),
                PanopticButton(
                  buttonType: ButtonType.bordered,
                  label: 'Remove Image',
                  onPressed: () {
                    state.didChange(state.value!
                        .where((element) => element != file)
                        .toList());
                  },
                ),
              ],
            ),
      ],
    );
  }

  static Widget _buildLabelWithHint(
      PanopticImageUploadFormFieldState state, String label, String? hintText) {
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

  @override
  PanopticFormFieldDecorationState<PanopticImageUploadFormField,
      List<CoreBaseFile>> createState() => PanopticImageUploadFormFieldState();
}

class PanopticImageUploadFormFieldState
    extends PanopticFormFieldDecorationState<PanopticImageUploadFormField,
        List<CoreBaseFile>> {}
