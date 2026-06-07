import 'package:evencir_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:evencir_app/features/home/presentation/pages/home_page.dart';
import 'package:evencir_app/features/mood/presentation/pages/mood_page.dart';
import 'package:evencir_app/features/profile/presentation/pages/profile_page.dart';
import 'package:evencir_app/features/shell/presentation/pages/main_shell_page.dart';
import 'package:evencir_app/features/training_plan/presentation/pages/training_plan_page.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static const homePath = '/home';
  static const calendarPath = '/calendar';
  static const planPath = '/plan';
  static const moodPath = '/mood';
  static const profilePath = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: homePath,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: planPath,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: TrainingPlanPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: moodPath,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MoodPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profilePath,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: calendarPath,
        builder: (context, state) => const CalendarPage(),
      ),
    ],
  );
}
