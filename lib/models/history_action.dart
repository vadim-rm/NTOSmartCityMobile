import 'package:json_annotation/json_annotation.dart';

part 'history_action.g.dart';

@JsonSerializable()
class HistoryAction {
  final String type;
  final String action;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime date;
  final int amount;
  final String userId;

  HistoryAction({
    required this.type,
    required this.action,
    required this.date,
    required this.amount,
    required this.userId,
  });

  factory HistoryAction.fromJson(Map<String, dynamic> json) =>
      _$HistoryActionFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryActionToJson(this);

  String get actionDescription {
    switch (action) {
      case "balance_increase":
        return "Баланс пополнен на\n$amount ByteCoin";
      case "buy":
        return "Покупка на $amount ByteCoin";
      case "trash_empty":
        return "Мусорный бак очищен";
      case "service":
        return "Мусорный бак переведен в режим обслуживания";
      case "overfill":
        return "Мусорный бак переполнен";
      case "login":
        return "Вход на мусорном баке";
      default:
        return "Действие";
    }
  }

  String get imagePath {
    switch (action) {
      case "balance_increase":
        return "assets/dollar.png";
      case "buy":
        return "assets/cart.png";
      case "trash_empty":
      case "service":
      case "overfill":
      case "login":
        return "assets/basket.png";
    }
    return "assets/dollar.png";
  }

  static DateTime _fromJson(int date) => DateTime.fromMillisecondsSinceEpoch(date);

  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
