import 'package:json_annotation/json_annotation.dart';
import 'package:nagib_pay/models/history_action.dart';

part 'container.g.dart';

@JsonSerializable()
class TrashContainer {
  final String type;
  final int trashCounter;
  final bool blocked;
  @JsonKey(ignore: true)
  final List<HistoryAction>? history;
  final String? id;

  TrashContainer({
    required this.type,
    this.history,
    this.trashCounter = 0,
    this.id,
    this.blocked = false,
  });

  TrashContainer copyWith({
    String? type,
    List<HistoryAction>? history,
    int? trashCounter,
    String? id,
    bool? blocked,
  }) {
    return TrashContainer(
      type: type ?? this.type,
      history: history ?? this.history,
      trashCounter: trashCounter ?? this.trashCounter,
      id: id ?? this.id,
      blocked: blocked ?? this.blocked,
    );
  }

  String get typeDescription {
    switch (type) {
      case "glass":
        return "Стекло";
      case "plastic":
        return "Пластик";
      case "paper":
        return "Бумага";
      default:
        return "";
    }
  }

  String get idDescription {
    return "Контейнер " + (id ?? "Err");
  }

  factory TrashContainer.fromJson(Map<String, dynamic> json) =>
      _$ContainerFromJson(json);

  Map<String, dynamic> toJson() => _$ContainerToJson(this);
}
