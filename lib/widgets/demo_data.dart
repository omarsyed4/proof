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

