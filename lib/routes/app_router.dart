import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/screens/login/bloc/login_bloc.dart';
import 'package:dashboard/screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardScreen(
        phone: state.uri.queryParameters['phone'] ?? '',
      ),
    ),
  ],
);
