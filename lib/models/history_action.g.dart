// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryAction _$HistoryActionFromJson(Map<String, dynamic> json) =>
    HistoryAction(
      type: json['type'] as String,
      action: json['action'] as String,
      date: HistoryAction._fromJson(json['date'] as int),
      amount: json['amount'] as int,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$HistoryActionToJson(HistoryAction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'action': instance.action,
      'date': HistoryAction._toJson(instance.date),
      'amount': instance.amount,
      'userId': instance.userId,
    };
