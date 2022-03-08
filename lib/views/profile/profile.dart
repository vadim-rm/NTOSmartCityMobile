import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/widgets/custom_appbar.dart';
import 'package:nagib_pay/widgets/profile_card.dart';

import '../../models/user.dart';
import '../../repository/user_repository.dart';
import '../../widgets/rounded_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SessionCubit sessionCubit = context.read<SessionCubit>();
    final Stream<DocumentSnapshot> userStream =
        context.read<UserRepository>().getUserStream();

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
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8,
        ),
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

                return ListView(
                  children: [
                    ProfileCard(user: newUser, showRole: true,),
                  ],
                );
              },
            ),
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
