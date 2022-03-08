import 'dart:io';

import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/widgets/search_bar.dart';

abstract class UsersEvent {}

class Init extends UsersEvent {}

class UsersChanged extends UsersEvent {
  final List<User?> users;

  UsersChanged({required this.users});
}

class SearchBarChanged extends UsersEvent {
  final String searchText;
  SearchBarChanged({required this.searchText});
}
