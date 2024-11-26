// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_base_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreBaseFile _$CoreBaseFileFromJson(Map<String, dynamic> json) => CoreBaseFile(
      id: (json['id'] as num?)?.toInt(),
      documentName: json['documentName'] as String?,
      contentType: json['contentType'] as String?,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      tagsString: json['tagsString'] as String?,
      uploadedDate: DateTime.parse(json['uploadedDate'] as String),
      uploadedBy: json['uploadedBy'] as String? ?? 'System',
    );

Map<String, dynamic> _$CoreBaseFileToJson(CoreBaseFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentName': instance.documentName,
      'contentType': instance.contentType,
      'content': instance.content,
      'tagsString': instance.tagsString,
      'uploadedDate': instance.uploadedDate.toIso8601String(),
      'uploadedBy': instance.uploadedBy,
    };
