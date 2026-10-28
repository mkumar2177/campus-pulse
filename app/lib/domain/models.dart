enum UserRole { student, organizer }
enum RegistrationStatus { registered, cancelled }
enum MatchRequestStatus { pending, accepted, rejected }
enum ConnectionStatus { pending, connected, declined }

class CampusNotification {
  const CampusNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.read = false,
  });
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool read;

  CampusNotification copyWith({bool? read}) => CampusNotification(
        id: id,
        title: title,
        body: body,
        createdAt: createdAt,
        read: read ?? this.read,
      );
}

class CampusConnection {
  const CampusConnection({
    required this.user,
    required this.status,
    required this.incoming,
  });
  final CampusUser user;
  final ConnectionStatus status;
  final bool incoming;
}

class CampusMessage {
  const CampusMessage({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.body,
    required this.sentAt,
  });
  final String id;
  final String senderId;
  final String recipientId;
  final String body;
  final DateTime sentAt;
}

class CampusUser {
  const CampusUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.subjects = const [],
    this.goal = '',
    this.availability = const {},
    this.visibleToMatches = true,
  });
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> subjects;
  final String goal;
  final Set<String> availability;
  final bool visibleToMatches;
}

class CampusEvent {
  const CampusEvent({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.organizer,
    required this.venue,
    required this.dateTime,
    required this.capacity,
    required this.registered,
    required this.tags,
    this.cancelled = false,
  });
  final String id;
  final String title;
  final String category;
  final String description;
  final String organizer;
  final String venue;
  final DateTime dateTime;
  final int capacity;
  final int registered;
  final List<String> tags;
  final bool cancelled;
  int get remainingSeats => capacity - registered;
}

class MatchBreakdown {
  const MatchBreakdown({
    required this.subjectScore,
    required this.goalScore,
    required this.availabilityScore,
    required this.totalScore,
    required this.reasons,
  });
  final double subjectScore;
  final double goalScore;
  final double availabilityScore;
  final double totalScore;
  final List<String> reasons;
}

class BuddyMatch {
  const BuddyMatch({required this.user, required this.breakdown});
  final CampusUser user;
  final MatchBreakdown breakdown;
}

class MatchRequest {
  const MatchRequest({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.status,
  });
  final String id;
  final String fromUserId;
  final String toUserId;
  final MatchRequestStatus status;
}
