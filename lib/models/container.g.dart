// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Container _$ContainerFromJson(Map<String, dynamic> json) => Container(
      type: json['type'] as String,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => HistoryAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      trashCounter: json['trashCounter'] as int? ?? 0,
    );

Map<String, dynamic> _$ContainerToJson(Container instance) => <String, dynamic>{
      'type': instance.type,
      'trashCounter': instance.trashCounter,
      'history': instance.history,
    };
