import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nagib_pay/models/user.dart';
import 'package:nagib_pay/repository/user_repository.dart';

class Avatar extends StatelessWidget {
  final User user;
  final UserRepository userRepository;

  const Avatar({
    Key? key,
    required this.user,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: userRepository.getAvatarUrl(userID: user.id),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        String? avatarUrl;
        if (snapshot.hasData) {
          avatarUrl = snapshot.data;
        }
        return Center(
          child: CircleAvatar(
            radius: 46,
            foregroundImage: avatarUrl != null
                ? CachedNetworkImageProvider(
                    avatarUrl,
                    cacheKey: user.id,
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
