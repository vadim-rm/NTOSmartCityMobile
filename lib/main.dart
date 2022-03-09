import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nagib_pay/app_navigator.dart';
import 'package:nagib_pay/bloc/session/session_cubit.dart';
import 'package:nagib_pay/firebase_options.dart';
import 'package:nagib_pay/repository/admin_repository.dart';
import 'package:nagib_pay/repository/auth_repository.dart';
import 'package:nagib_pay/repository/user_repository.dart';
import 'package:nagib_pay/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const NagibPay());
}

class NagibPay extends StatelessWidget {
  const NagibPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NagibPay',
      theme: nagibTheme,
      debugShowCheckedModeBanner: false,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthRepository(),
          ),
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => AdminRepository(),
          ),
        ],
        child: BlocProvider(
          create: (context) => SessionCubit(
            userRepository: context.read<UserRepository>(),
          ),
          child: AppNavigator(),
        ),
      ),
    );
  }
}
