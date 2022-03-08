import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';

import '../../models/user.dart';
import '../../repository/user_repository.dart';
import '../../widgets/rounded_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? avatarUrl;

  Widget _avatar(String? url, User user) {
    return Center(
      child: CircleAvatar(
        radius: 46,
        foregroundImage: url != null && url != ""
            ? NetworkImage(
                url,
              )
            : null,
        child: Text(
          user.initials,
          style: const TextStyle(fontSize: 36),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SessionCubit sessionCubit = context.read<SessionCubit>();
    final Stream<DocumentSnapshot> userStream =
        context.read<UserRepository>().getUserStream();
    final UserRepository userRepository = context.read<UserRepository>();

    if (avatarUrl == null) {
      userRepository.getAvatarUrl().then(
            (url) => setState(() => avatarUrl = url),
          );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Профиль"),
        buttons: [
          IconButton(
            onPressed: () =>
                BlocProvider.of<SessionCubit>(context).showEditView(),
            icon: const Icon(
              FeatherIcons.edit2,
              color: Colors.black26,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: userStream,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Что-пошло не так');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  User newUser = User.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  sessionCubit.setUser(user: newUser);

                  return RefreshIndicator(
                    onRefresh: () async {
                      String? url = await userRepository.getAvatarUrl();
                      if (url != null) {
                        setState(
                          () {
                            avatarUrl = url;
                          },
                        );
                      }
                    },
                    child: ListView(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                _avatar(avatarUrl, newUser),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newUser.roleDescription,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      newUser.fullName,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      newUser.middleName,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      newUser.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            RoundedButton(
              text: "Выйти",
              onPressed: () async {
                context.read<SessionCubit>().signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
