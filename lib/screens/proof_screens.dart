import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/demo_data.dart';
import '../widgets/proof_style.dart';

const screenNames = [
  'Sign in',
  'Today',
  'Goals',
  'Add a goal',
  'Camera check-in',
  'Post check-in',
  'Feed',
  'Friends',
  'This week',
  'Reminders',
];
const screenRoutes = [
  '/sign-in',
  '/today',
  '/goals',
  '/add-goal',
  '/camera',
  '/post',
  '/feed',
  '/friends',
  '/week',
  '/reminders',
];
void go(BuildContext context, String route) =>
    Navigator.of(context).pushNamed(route);

class ProofPage extends StatelessWidget {
  final String title;
  final Widget child;
  const ProofPage({super.key, required this.title, required this.child});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
              child: Row(
                children: [
                  Expanded(child: label(title, size: 28, bold: true)),
                  PopupMenuButton<String>(
                    tooltip: 'Screens',
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    color: Colors.white,
                    icon: const Icon(Icons.menu_rounded, color: muted),
                    onSelected: (route) => go(context, route),
                    itemBuilder:
                        (_) => [
                          for (int i = 0; i < screenNames.length; i++)
                            PopupMenuItem(
                              value: screenRoutes[i],
                              child: Text(screenNames[i]),
                            ),
                        ],
                  ),
                ],
              ),
            ),
            gap(4),
            Expanded(child: child),
          ],
        ),
      ),
    ),
  );
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder:
            (context, box) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  30,
                  math.max(72, box.maxHeight * .15),
                  30,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: label('Proof', size: 34, bold: true)),
                    gap(12),
                    Center(
                      child: Text(
                        'Habit check-ins\nwith friends',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 16,
                          height: 1.15,
                        ),
                      ),
                    ),
                    gap(38),
                    label('Username', size: 12),
                    gap(6),
                    field('yourusername'),
                    gap(14),
                    label('Password', size: 12),
                    gap(6),
                    field('••••••••', password: true),
                    gap(22),
                    primary('Sign in', () => go(context, '/today')),
                    gap(12),
                    Center(
                      child: TextButton(
                        onPressed: uiOnly,
                        child: const Text('Create an account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    ),
  );
}

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});
  @override
  Widget build(BuildContext context) => ProofPage(
    title: 'Your week',
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => go(context, '/week'),
            child: card(
              Column(
                children: [
                  for (final g in myGoals) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label(g.name, size: 16, bold: true),
                        label(
                          '${checkInsFor(g).length} of ${g.targetCount}',
                          size: 12,
                          color: muted,
                        ),
                      ],
                    ),
                    gap(8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: checkInsFor(g).length / g.targetCount,
                        minHeight: 10,
                        backgroundColor: pale,
                        color: green,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  Widget _openGoal(
    String name,
    String action,
    Color color,
    VoidCallback onTap,
  ) => InkWell(
    onTap: onTap,
    child: card(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          gap(5),
          label(name, size: 16, bold: true),
          gap(8),
          label('$action  ›', color: green, bold: true, size: 13),
        ],
      ),
    ),
  );
}

Widget _friendRow(CheckIn c) => Row(
  children: [
    avatar(ownerOf(c).displayName),
    const SizedBox(width: 12),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(ownerOf(c).displayName, bold: true),
          label(goalFor(c).name, size: 12, color: muted),
        ],
      ),
    ),
    label(timeOf(c), size: 11, color: muted),
  ],
);

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

// Dashed outlines match the missed-day markers in the mockups.
class DashedBorder extends CustomPainter {
  final Color color;
  final double radius;
  DashedBorder({this.color = line, this.radius = 8});
  @override
  void paint(Canvas canvas, Size size) {
    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
        );
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;
    for (final metric in path.computeMetrics()) {
      for (double distance = 0; distance < metric.length; distance += 5) {
        canvas.drawPath(
          metric.extractPath(distance, math.min(distance + 2.5, metric.length)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorder oldDelegate) =>
      color != oldDelegate.color || radius != oldDelegate.radius;
}
