import 'package:dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:dashboard/screens/home/home_page.dart';
import 'package:dashboard/screens/login/bloc/login_bloc.dart';
import 'package:dashboard/screens/login/login_screen.dart';
import 'package:dashboard/screens/notifications/notification_page.dart';
import 'package:dashboard/screens/profile/profile_page.dart';
import 'package:dashboard/screens/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// final appRouter = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => BlocProvider(
//         create: (context) => LoginBloc(),
//         child: const Directionality(
//             textDirection: TextDirection.rtl, child: LoginScreen()),
//       ),
//     ),
//     GoRoute(
//       path: '/dashboard',
//       builder: (context, state) => Directionality(
//         textDirection: TextDirection.rtl,
//         child: DashboardScreen(
//           phone: state.uri.queryParameters['phone'] ?? '', child: null,
//         ),
//       ),
//     ),
//   ],
// );

bool isLoggedIn = false;
//temporary Token storage simulation
bool savedTokenAuth = false;
final appRouter = GoRouter(
  redirect: (context, state) {
    isLoggedIn = context.read<LoginBloc>().state is LoginSuccess;
    final isGoingToLogin = state.uri.path == '/login';

    if (!savedTokenAuth && !isLoggedIn && !isGoingToLogin) {
      savedTokenAuth = true;
      return '/login';
    }

    if (!savedTokenAuth && isLoggedIn && isGoingToLogin) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Directionality(
          textDirection: TextDirection.rtl, child: LoginScreen()),
    ),
    ShellRoute(
      builder: (context, state, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: DashboardScreen(child: child)),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationsPage(),
        ),
      ],
    ),
  ],
);
