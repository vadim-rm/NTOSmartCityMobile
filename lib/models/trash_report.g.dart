// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trash_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrashReport _$TrashReportFromJson(Map<String, dynamic> json) => TrashReport(
      status: (json['status'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                $enumDecode(_$SensorTypeEnumMap, k),
                (e as Map<String, dynamic>).map(
                  (k, e) =>
                      MapEntry($enumDecode(_$TrashTypeEnumMap, k), e as bool),
                )),
          ) ??
          const {
            SensorType.color: {
              TrashType.glass: false,
              TrashType.paper: false,
              TrashType.plastic: false
            },
            SensorType.distance: {
              TrashType.glass: false,
              TrashType.paper: false,
              TrashType.plastic: false
            },
            SensorType.servo: {
              TrashType.glass: false,
              TrashType.paper: false,
              TrashType.plastic: false
            }
          },
      date: TrashReport._fromJson(json['date'] as int),
    );

Map<String, dynamic> _$TrashReportToJson(TrashReport instance) =>
    <String, dynamic>{
      'status': instance.status.map((k, e) => MapEntry(_$SensorTypeEnumMap[k],
          e.map((k, e) => MapEntry(_$TrashTypeEnumMap[k], e)))),
      'date': TrashReport._toJson(instance.date),
    };

const _$TrashTypeEnumMap = {
  TrashType.glass: 'glass',
  TrashType.plastic: 'plastic',
  TrashType.paper: 'paper',
};

const _$SensorTypeEnumMap = {
  SensorType.servo: 'servo',
  SensorType.color: 'color',
  SensorType.distance: 'distance',
};
