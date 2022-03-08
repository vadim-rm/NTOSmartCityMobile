import 'package:flutter/material.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/profile_big_card.dart';

class UserDetailsView extends StatelessWidget {
  final User user;

  const UserDetailsView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text("Информация о пользователе")),
      body: ListView(children: [
        ProfileBigCard(user: user),
      ]),
    );
  }
}
