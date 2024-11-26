// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreFile _$CoreFileFromJson(Map<String, dynamic> json) => CoreFile(
      id: (json['id'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      contentType: json['contentType'] as String?,
      documentName: json['documentName'] as String?,
      tagsString: json['tagsString'] as String?,
      uploadedBy: json['uploadedBy'] as String? ?? 'System',
      uploadedDate: DateTime.parse(json['uploadedDate'] as String),
      downloadInBrowser: json['downloadInBrowser'] as String?,
      lastModified: DateTime.parse(json['lastModified'] as String),
      size: (json['size'] as num?)?.toInt(),
      tempId: json['tempId'] as String?,
      viewInBrowser: json['viewInBrowser'] as String?,
    );

Map<String, dynamic> _$CoreFileToJson(CoreFile instance) => <String, dynamic>{
      'id': instance.id,
      'documentName': instance.documentName,
      'contentType': instance.contentType,
      'content': instance.content,
      'tagsString': instance.tagsString,
      'uploadedDate': instance.uploadedDate.toIso8601String(),
      'uploadedBy': instance.uploadedBy,
      'lastModified': instance.lastModified.toIso8601String(),
      'size': instance.size,
      'viewInBrowser': instance.viewInBrowser,
      'downloadInBrowser': instance.downloadInBrowser,
      'tempId': instance.tempId,
    };
