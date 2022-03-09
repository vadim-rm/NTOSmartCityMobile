// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      middleName: json['middleName'] as String? ?? '',
      address: json['address'] as String? ?? '',
      balance: json['balance'] as int? ?? 0,
      role: json['role'] as String? ?? 'user',
      trashCounter: json['trashCounter'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'middleName': instance.middleName,
      'address': instance.address,
      'balance': instance.balance,
      'role': instance.role,
      'trashCounter': instance.trashCounter,
    };
