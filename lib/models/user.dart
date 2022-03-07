import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  final double balance;

  User({
    required this.name,
    required this.surname,
    required this.balance,
  });

  User copyWith({
    String? name,
    String? surname,
    double? balance,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      balance: balance ?? this.balance,
    );
  }

  bool get isInfoNeeded => name == "" || surname == "";

  @override
  operator ==(other) =>
      other is User && other.name == name && other.surname == surname;

  @override
  int get hashCode => hashValues(name, surname, balance);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
