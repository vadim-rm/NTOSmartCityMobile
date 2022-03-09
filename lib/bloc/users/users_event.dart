
import 'package:nagib_pay/models/user.dart';

abstract class UsersEvent {}

class Init extends UsersEvent {}

class UsersChanged extends UsersEvent {
  final List<User?> users;

  UsersChanged({required this.users});
}

class SearchBarTextChanged extends UsersEvent {
  final String text;
  SearchBarTextChanged({required this.text});
}
