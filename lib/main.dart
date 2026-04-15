import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_page.dart';
import 'features/game/habit_game_page.dart';
import 'features/game/data/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  await dotenv.load(fileName: '.env');

  runApp(const HealthyHabitsApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => _HomeShell(),
    ),
    GoRoute(
      path: '/game/:habitId',
      builder: (context, state) {
        final habitId = state.pathParameters['habitId']!;
        return HabitGamePage(
          habitId: habitId,
          onBack: () => context.go('/'),
        );
      },
    ),
  ],
);

class HealthyHabitsApp extends StatelessWidget {
  const HealthyHabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Healthy Habits',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)),
        useMaterial3: true,
      ),
    );
  }
}

class _HomeShell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(
        onHabitPress: (HabitCard habit) {
          context.go('/game/${habit.id}');
        },
      ),
    );
  }
}
