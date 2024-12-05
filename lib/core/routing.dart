import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_feed/main.dart';

import '../features/auth/presentation/controllers/login_cubit.dart';
import '../features/auth/presentation/controllers/register_cubit.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import 'get_it.dart';

class AppRouter {
  static const String mainScreen = "/";
  static const String registerScreen = "/registerScreen";
  static const String loginScreen = "/loginScreen";

  // Fetch the page widget based on route name
  Widget? getPage(String routeName) {
    switch (routeName) {
      case mainScreen:
        return const MainScreen();
      case registerScreen:
        return BlocProvider.value(
          value: getIt<RegisterCubit>(),
          child: RegisterScreen(),
        );
      case loginScreen:
        return BlocProvider.value(
          value: getIt<LoginCubit>(),
          child: LoginScreen(),
        );
      default:
        return null;
    }
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    final AppRouter router = AppRouter();
    return MaterialPageRoute(
      builder: (_) => router.getPage(settings.name!) ?? LoginScreen(),
      settings: settings,
    );
  }
}
