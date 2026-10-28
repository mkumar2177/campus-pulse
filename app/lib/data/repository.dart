import '../domain/models.dart';

abstract interface class CampusRepository {
  Future<void> initialize();
  bool get isAuthenticated;
  Future<void> signIn({required String email, required String password});
  Future<void> signOut();
  CampusUser get currentUser;
  List<CampusEvent> get events;
  List<CampusUser> get candidates;
  Set<String> get bookmarkedEventIds;
  List<MatchRequest> get matchRequests;
  List<CampusConnection> get connections;
  List<CampusNotification> get notifications;
  List<CampusMessage> messagesFor(String userId);
  Future<void> saveProfile({
    required List<String> subjects,
    required String goal,
    required Set<String> availability,
  });
  Future<void> toggleBookmark(String eventId);
  Future<void> register(String eventId);
  Future<void> sendMatchRequest(String userId);
  Future<void> requestConnection(String userId);
  Future<void> updateConnection(String userId, ConnectionStatus status);
  Future<void> markNotificationRead(String notificationId);
  Future<void> markAllNotificationsRead();
  Future<void> sendMessage(String userId, String body);
  Future<void> signUp({required String name, required String email, required String password});
  Future<void> reset();
}
