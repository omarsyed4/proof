// Sample data for the screens. Firebase comes later.
class User {
  final String id, username, displayName, passwordHash;
  final String? profilePhotoUrl;
  final DateTime createdAt;
  const User(
    this.id,
    this.username,
    this.displayName,
    this.passwordHash,
    this.profilePhotoUrl,
    this.createdAt,
  );
}

class ReminderSettings {
  final String id, userId, quietHoursStart, quietHoursEnd;
  final int maxPerDay;
  final bool stopOnCheckin;
  const ReminderSettings(
    this.id,
    this.userId,
    this.maxPerDay,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.stopOnCheckin,
  );
}

class Friendship {
  final String id, requesterId, addresseeId, status;
  final DateTime createdAt;
  const Friendship(
    this.id,
    this.requesterId,
    this.addresseeId,
    this.status,
    this.createdAt,
  );
}

enum ProofType { photo, confirm }

class Goal {
  final String id, userId, name;
  final ProofType proofType;
  final int targetCount;
  final DateTime weekStartDate;
  final bool isPaused, showMisses;
  const Goal(
    this.id,
    this.userId,
    this.name,
    this.proofType,
    this.targetCount,
    this.weekStartDate, {
    this.isPaused = false,
    this.showMisses = false,
  });
}

class GoalShare {
  final String goalId, viewerUserId;
  const GoalShare(this.goalId, this.viewerUserId);
}

class CheckIn {
  final String id, goalId;
  final String? photoUrl, note;
  final DateTime checkinAt;
  const CheckIn(this.id, this.goalId, this.photoUrl, this.note, this.checkinAt);
  int get dayOfWeek => checkinAt.weekday;
}

class Comment {
  final String id, checkinId, authorUserId, text;
  final DateTime createdAt;
  const Comment(
    this.id,
    this.checkinId,
    this.authorUserId,
    this.text,
    this.createdAt,
  );
}

class Reaction {
  final String id, checkinId, userId, reactionType;
  final DateTime createdAt;
  const Reaction(
    this.id,
    this.checkinId,
    this.userId,
    this.reactionType,
    this.createdAt,
  );
}

// Keep the same sample week as the mockups.
final weekStart = DateTime(2026, 9, 14);
final users = [
  User('you', 'yourusername', 'You', 'demo-placeholder', null, weekStart),
  User('omar', 'omar', 'Omar', 'demo-placeholder', null, weekStart),
  User('griffin', 'griffin', 'Griffin', 'demo-placeholder', null, weekStart),
  User('latrell', 'latrell', 'Latrell', 'demo-placeholder', null, weekStart),
];
const reminderSettings = ReminderSettings(
  'settings-you',
  'you',
  2,
  '10 p.m.',
  '8 a.m.',
  true,
);
final friendships = [
  for (final id in ['omar', 'griffin', 'latrell'])
    Friendship('friend-$id', 'you', id, 'accepted', weekStart),
];
final goals = [
  Goal('gym', 'you', 'Gym', ProofType.photo, 4, weekStart),
  Goal('reading', 'you', 'Reading', ProofType.confirm, 5, weekStart),
  Goal('omar-gym', 'omar', 'Gym', ProofType.photo, 4, weekStart),
  Goal('griffin-run', 'griffin', 'Run', ProofType.photo, 3, weekStart),
];
const goalShares = [
  GoalShare('gym', 'omar'),
  GoalShare('gym', 'griffin'),
  GoalShare('omar-gym', 'you'),
  GoalShare('griffin-run', 'you'),
];
final checkIns = [
  CheckIn('gym-m', 'gym', 'demo:green', null, DateTime(2026, 9, 14, 16)),
  CheckIn('gym-w', 'gym', 'demo:green', null, DateTime(2026, 9, 16, 16)),
  for (int day = 14; day <= 16; day++)
    CheckIn('reading-$day', 'reading', null, null, DateTime(2026, 9, day, 20)),
  CheckIn(
    'omar-today',
    'omar-gym',
    'demo:green',
    null,
    DateTime(2026, 9, 16, 16, 12),
  ),
  CheckIn(
    'griffin-today',
    'griffin-run',
    'demo:sand',
    null,
    DateTime(2026, 9, 16, 7, 2),
  ),
];
final comments = [
  Comment(
    'c1',
    'omar-today',
    'omar',
    "that's three this week",
    DateTime(2026, 9, 16, 16, 13),
  ),
  Comment(
    'c2',
    'griffin-today',
    'griffin',
    'finally',
    DateTime(2026, 9, 16, 7, 3),
  ),
];
final reactions = [
  Reaction(
    'r1',
    'omar-today',
    'griffin',
    'encouragement',
    DateTime(2026, 9, 16, 16, 14),
  ),
];
