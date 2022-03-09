// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrashContainer _$TrashContainerFromJson(Map<String, dynamic> json) =>
    TrashContainer(
      type: json['type'] as String,
      trashCounter: json['trashCounter'] as int? ?? 0,
      id: json['id'] as String?,
      blocked: json['blocked'] as bool? ?? false,
    );

Map<String, dynamic> _$TrashContainerToJson(TrashContainer instance) =>
    <String, dynamic>{
      'type': instance.type,
      'trashCounter': instance.trashCounter,
      'blocked': instance.blocked,
      'id': instance.id,
    };
