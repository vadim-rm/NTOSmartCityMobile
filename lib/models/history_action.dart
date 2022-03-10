import 'package:json_annotation/json_annotation.dart';
import 'package:nagib_pay/models/user.dart';

part 'history_action.g.dart';

@JsonSerializable()
class HistoryAction {
  final String type;
  final String action;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime date;
  final int amount;
  final String userId;

  @JsonKey(ignore: true)
  final User? user;

  HistoryAction({
    required this.type,
    required this.action,
    required this.date,
    required this.amount,
    required this.userId,
    this.user,
  });

  HistoryAction copyWith({
    String? type,
    String? action,
    DateTime? date,
    int? amount,
    String? userId,
    User? user,
  }) {
    return HistoryAction(
      type: type ?? this.type,
      action: action ?? this.action,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      user: user ?? this.user,
    );
  }

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
      case "report_created":
        return "Создан новый отчет";
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
      case "report_created":
        return "assets/wrench.png";
    }
    return "assets/dollar.png";
  }

  static DateTime _fromJson(int date) =>
      DateTime.fromMillisecondsSinceEpoch(date);

  static int _toJson(DateTime time) => time.millisecondsSinceEpoch;
}
