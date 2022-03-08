import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  final String middleName;
  final String address;
  final double balance;
  final String role;
  final int trashCounter;

  User({
    this.name = '',
    this.surname = '',
    this.middleName = '',
    this.address = '',
    this.balance = 0,
    this.role = 'user',
    this.trashCounter = 0,
  });

  User copyWith({
    String? name,
    String? surname,
    String? middleName,
    String? address,
    double? balance,
    String? role,
    int? trashCounter,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      middleName: middleName ?? this.middleName,
      address: address ?? this.address,
      balance: balance ?? this.balance,
      role: role ?? this.role,
      trashCounter: trashCounter ?? this.trashCounter,
    );
  }

  bool get isInfoNeeded => name == "" || surname == "";

  String get roleDescription {
    switch (role) {
      case 'user':
        return 'Пользователь';
      case 'admin':
        return 'Администратор';
      case "staff":
        return "Обслуживающий\nперсонал";
    }
    return "";
  }

  String get fullName => "$surname $name";

  String get initials {
    if (name.isNotEmpty && surname.isNotEmpty) {
      return "${surname[0].toUpperCase()}${name[0].toUpperCase()}";
    }
    return "__";
  }

  @override
  operator ==(other) =>
      other is User && other.name == name && other.surname == surname;

  @override
  int get hashCode => hashValues(name, surname, balance);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
