import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_page.dart';
import 'features/game/habit_game_page.dart';
import 'features/game/data/models.dart';
import 'features/home/widgets/bottom_nav.dart';
import 'features/quiz/daily_quiz_page.dart';

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
      builder: (context, state) => const _HomeShell(),
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
  const _HomeShell();

  @override
  Widget build(BuildContext context) => const _TabShell();
}

class _TabShell extends StatefulWidget {
  const _TabShell();

  @override
  State<_TabShell> createState() => _TabShellState();
}

class _TabShellState extends State<_TabShell> {
  int _index = 0;

  void _setIndex(int idx) {
    if (idx == _index) return;
    setState(() => _index = idx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _index,
              children: [
                HomePage(
                  onHabitPress: (HabitCard habit) {
                    context.go('/game/${habit.id}');
                  },
                ),
                const DailyQuizPage(),
                const _PlaceholderPage(title: 'Progress'),
                const _PlaceholderPage(title: 'Settings'),
              ],
            ),
          ),
          BottomNav(selectedIndex: _index, onSelect: _setIndex),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title (coming soon)',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }
}
