import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lozalife/features/boards/presentation/screens/adaptive_board_shell.dart';
import 'package:lozalife/features/tasks/presentation/screens/task_screen.dart';

/// Application routes. Both the boards list and an opened board are served
/// by the same adaptive shell: the layout adapts to the screen width.
final Provider<GoRouter> appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AdaptiveBoardShell(),
      ),
      GoRoute(
        path: '/board/:boardId',
        builder: (context, state) => AdaptiveBoardShell(
          boardId: state.pathParameters['boardId'],
        ),
      ),
      GoRoute(
        path: '/task/:taskId',
        builder: (context, state) => TaskScreen(
          taskId: state.pathParameters['taskId']!,
        ),
      ),
    ],
  ),
);
