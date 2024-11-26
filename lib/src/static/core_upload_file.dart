import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:panoptic_widgets/src/static/core_base_file.dart';

part 'core_upload_file.g.dart';

@JsonSerializable()
class CoreUploadFile {
  int? id;

  String? documentName;

  String? contentType;

  String? content;

  String? tagsString;

  DateTime uploadedDate;

  String uploadedBy;

  CoreUploadFile({
    this.id,
    this.documentName,
    this.contentType,
    this.content,
    this.tagsString,
    required this.uploadedDate,
    this.uploadedBy = 'System',
  });

  factory CoreUploadFile.fromJson(Map<String, dynamic> json) =>
      _$CoreUploadFileFromJson(json);

  Map<String, dynamic> toJson() => _$CoreUploadFileToJson(this);

  List<String>? getTags({String delimiter = ';'}) {
    return tagsString?.split(delimiter);
  }

  static String convertExtensionToMimeType(String extension) {
    switch (extension) {
      case "pdf":
        return "application/pdf";
      case "doc":
        return "application/msword";
      case "docx":
        return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
      case "xls":
        return "application/vnd.ms-excel";
      case "xlsx":
        return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
      case "ppt":
        return "application/vnd.ms-powerpoint";
      case "pptx":
        return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
      case "txt":
        return "text/plain";
      case "rtf":
        return "application/rtf";
      case "png":
        return "image/png";
      case "jpg":
        return "image/jpeg";
      case "jpeg":
        return "image/jpeg";
      case "gif":
        return "image/gif";
      case "bmp":
        return "image/bmp";
    }
    return "application/octet-stream";
  }

  static CoreUploadFile fromCore(CoreBaseFile file) {
    return CoreUploadFile(uploadedDate: DateTime.now())
      ..id = file.id
      ..documentName = file.documentName
      ..contentType = file.contentType
      ..content = base64Encode(file.content!)
      ..tagsString = file.tagsString
      ..uploadedDate = file.uploadedDate
      ..uploadedBy = file.uploadedBy;
  }
}
