import 'package:json_annotation/json_annotation.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';

part 'trash_report.g.dart';

@JsonSerializable()
class TrashReport {
  final Map<SensorType, Map<TrashType, bool>> status;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime? date;

  const TrashReport({
    this.status = const {
      SensorType.color: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
      SensorType.distance: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
      SensorType.servo: {
        TrashType.glass: false,
        TrashType.paper: false,
        TrashType.plastic: false,
      },
    },
    this.date,
  });

  TrashReport copyWith({
    Map<SensorType, Map<TrashType, bool>>? status,
    DateTime? date,
  }) {
    return TrashReport(
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  factory TrashReport.fromJson(Map<String, dynamic> json) =>
      _$TrashReportFromJson(json);

  Map<String, dynamic> toJson() => _$TrashReportToJson(this);

  static DateTime _fromJson(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date);

  static int? _toJson(DateTime? time) => time!.millisecondsSinceEpoch;
}
