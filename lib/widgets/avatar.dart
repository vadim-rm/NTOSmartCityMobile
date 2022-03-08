import 'package:flutter/material.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';

class Avatar extends StatelessWidget {
  final String? userId;
  final User user;
  final UserRepository userRepository;

  const Avatar({
    Key? key,
    this.userId,
    required this.user,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: userRepository.getAvatarUrl(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        String? avatarUrl;
        if (snapshot.hasData) {
          avatarUrl = snapshot.data;
        }
        return Center(
          child: CircleAvatar(
            radius: 46,
            foregroundImage: avatarUrl != null
                ? NetworkImage(
                    avatarUrl,
                  )
                : null,
            child: Text(
              user.initials,
              style: const TextStyle(fontSize: 36),
            ),
          ),
        );
      },
    );
  }
}
