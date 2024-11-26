import 'package:json_annotation/json_annotation.dart';
import 'package:panoptic_widgets/src/static/core_base_file.dart';

part 'core_file.g.dart';

@JsonSerializable()
class CoreFile extends CoreBaseFile {
  late DateTime lastModified;
  int? size;
  String? viewInBrowser;
  String? downloadInBrowser;
  String? tempId;

  CoreFile(
      {super.id,
      super.content,
      super.contentType,
      super.documentName,
      super.tagsString,
      super.uploadedBy,
      required super.uploadedDate,
      this.downloadInBrowser,
      required this.lastModified,
      this.size,
      this.tempId,
      this.viewInBrowser});

  factory CoreFile.fromJson(Map<String, dynamic> json) =>
      _$CoreFileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CoreFileToJson(this);
}
