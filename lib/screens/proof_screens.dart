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
          gap(12),
          label('STILL OPEN TODAY', size: 13, color: muted),
          gap(12),
          Row(
            children: [
              Expanded(
                child: _openGoal(
                  'Gym',
                  'Take proof',
                  pale,
                  () => go(context, '/camera'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _openGoal(
                  'Reading',
                  'Log 20 min',
                  const Color(0xFFFBEBD3),
                  uiOnly,
                ),
              ),
            ],
          ),
          gap(12),
          label('FRIENDS TODAY', size: 13, color: muted),
          gap(12),
          InkWell(
            onTap: () => go(context, '/feed'),
            child: card(
              Column(
                children: [
                  for (final c in friendCheckIns)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: _friendRow(c),
                    ),
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
  Widget build(BuildContext context) => ProofPage(
    title: 'Goals',
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label('Week of Sep 14', color: muted),
          gap(10),
          for (final g in myGoals) ...[
            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: label(g.name, size: 18, bold: true)),
                      InkWell(
                        onTap: () => go(context, '/add-goal'),
                        child: label('Edit', size: 13, color: green),
                      ),
                    ],
                  ),
                  gap(8),
                  label(
                    '${g.proofType == ProofType.photo ? 'Photo' : 'Confirm'} · ${g.targetCount} times',
                    color: muted,
                    size: 13,
                  ),
                  gap(10),
                  chip(
                    viewers(g).isEmpty
                        ? 'Only you'
                        : 'Visible to ${viewers(g).map((u) => u.displayName).join(', ')}',
                    private: viewers(g).isEmpty,
                  ),
                ],
              ),
            ),
            gap(14),
          ],
          SizedBox(
            width: double.infinity,
            height: 48,
            child: CustomPaint(
              painter: DashedBorder(),
              child: TextButton(
                onPressed: () => go(context, '/add-goal'),
                child: const Text('+  Add a goal'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({super.key});
  @override
  Widget build(BuildContext context) => ProofPage(
    title: 'Add a goal',
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label('Goal name', size: 12),
          gap(6),
          field('', value: myGoals.first.name),
          gap(14),
          label('Times this week', size: 12),
          gap(7),
          Row(
            children: [
              _step('−'),
              const SizedBox(width: 12),
              _step('${myGoals.first.targetCount}', strong: true),
              const SizedBox(width: 12),
              _step('+'),
            ],
          ),
          gap(14),
          label('Proof', size: 12),
          gap(6),
          Row(
            children: [
              Expanded(child: _proof('Photo', 'default', true)),
              const SizedBox(width: 12),
              Expanded(child: _proof('Confirm', 'no camera', false)),
            ],
          ),
          gap(14),
          label('Who can see this', size: 12),
          gap(6),
          card(
            Column(
              children: [
                for (final u in acceptedFriends)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                            color:
                                viewers(myGoals.first).contains(u)
                                    ? green
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color:
                                  viewers(myGoals.first).contains(u)
                                      ? green
                                      : line,
                            ),
                          ),
                          child:
                              viewers(myGoals.first).contains(u)
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 17,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 12),
                        label(u.displayName, size: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          gap(14),
          label('Show misses to them?', size: 12),
          gap(7),
          Row(
            children: [
              const Icon(Icons.radio_button_unchecked, size: 21, color: line),
              const SizedBox(width: 7),
              label('Yes'),
              const SizedBox(width: 22),
              const Icon(Icons.radio_button_checked, size: 21, color: green),
              const SizedBox(width: 7),
              label('No'),
            ],
          ),
          gap(26),
          primary('Pause this week', uiOnly, outlined: true),
          gap(16),
          primary('Save', uiOnly),
        ],
      ),
    ),
  );
  Widget _step(String title, {bool strong = false}) => Container(
    width: 58,
    height: 46,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: line),
      borderRadius: BorderRadius.circular(4),
    ),
    child: label(
      title,
      size: 18,
      color: strong ? ink : const Color(0xFF95A19A),
      bold: strong,
    ),
  );
  Widget _proof(String title, String subtitle, bool selected) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: selected ? pale : Colors.white,
      borderRadius: BorderRadius.circular(9),
      border: Border.all(color: selected ? green : line),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(title, size: 17),
        gap(4),
        label(subtitle, size: 12, color: muted),
      ],
    ),
  );
}

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF13221E),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                tooltip: 'Close camera',
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(backgroundColor: Colors.white12),
                onPressed: () => go(context, '/today'),
                icon: const Icon(Icons.close, size: 17, color: Colors.white),
              ),
            ),
            gap(16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF3A4A44)),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2A3C36), Color(0xFF13221E)],
                  ),
                ),
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: .7,
                    heightFactor: .55,
                    child: CustomPaint(
                      painter: DashedBorder(
                        color: const Color(0xFF7E8F86),
                        radius: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            gap(20),
            Center(
              child: Semantics(
                label: 'Shutter: preview post check-in',
                button: true,
                child: GestureDetector(
                  onTap: () => go(context, '/post'),
                  child: Container(
                    width: 68,
                    height: 68,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF8FAF9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
  @override
  Widget build(BuildContext context) => ProofPage(
    title: 'Post check-in',
    child: LayoutBuilder(
      builder:
          (context, box) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    photo(height: math.min(430, box.maxHeight * .55)),
                    gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        label('Gym', size: 18, bold: true),
                        label('Just now', size: 12),
                      ],
                    ),
                    gap(12),
                    label('Note (optional)', size: 12),
                    gap(6),
                    field('Say something about today...'),
                    gap(20),
                    const Spacer(),
                    primary('Post check-in', uiOnly),
                    gap(8),
                    Center(
                      child: TextButton(
                        onPressed: () => go(context, '/camera'),
                        child: const Text(
                          'Retake',
                          style: TextStyle(
                            color: muted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) => ProofPage(
    title: 'Feed',
    child: SingleChildScrollView(
      child: Column(
        children: [
          for (final c in friendCheckIns) ...[
            card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: photo(
                      height: 220,
                      second: c.photoUrl == 'demo:sand',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                    child: Column(
                      children: [
                        _friendRow(c),
                        gap(10),
                        // Keep the written comment above the quick reaction.
                        for (final comment in comments.where(
                          (comment) => comment.checkinId == c.id,
                        ))
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: paper,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${userFor(comment.authorUserId).displayName}: ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: '“${comment.text}”'),
                                ],
                              ),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        gap(9),
                        Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              size: 14,
                              color: green,
                            ),
                            const SizedBox(width: 6),
                            label('Comment', color: green, size: 13),
                            const SizedBox(width: 18),
                            const Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: muted,
                            ),
                            const SizedBox(width: 6),
                            label('React', color: muted, size: 13),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.zero,
            ),
            gap(14),
          ],
        ],
      ),
    ),
  );
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
