// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrashContainer _$ContainerFromJson(Map<String, dynamic> json) => TrashContainer(
      type: json['type'] as String,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => HistoryAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      trashCounter: json['trashCounter'] as int? ?? 0,
    );

Map<String, dynamic> _$ContainerToJson(TrashContainer instance) => <String, dynamic>{
      'type': instance.type,
      'trashCounter': instance.trashCounter,
      'history': instance.history,
    };
