import 'dart:developer' as developer;

import '../domain/models.dart';
import 'repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart' as remote;
import '../config/app_config.dart';

class LocalRepository implements CampusRepository {
  LocalRepository() {
    _user = const CampusUser(
      id: 'student-a',
      name: 'Student A',
      email: 'student@campuspulse.demo',
      role: UserRole.student,
      subjects: ['DSA', 'Web Dev'],
      goal: 'Placement preparation',
      availability: {'Saturday afternoon', 'Sunday morning'},
    );
    _seed();
  }
  SharedPreferences? _preferences;
  remote.Client? _client;
  bool _serverConnected = false;
  bool _authenticated = false;
  late CampusUser _user;
  late List<CampusEvent> _events;
  final Set<String> _bookmarks = {};
  final List<MatchRequest> _requests = [];
  final List<CampusConnection> _connections = [];
  final List<CampusNotification> _notifications = [];
  final List<CampusMessage> _messages = [];
  final List<CampusUser> _candidates = const [
    CampusUser(
      id: 'student-b',
      name: 'Student B',
      email: 'b@campuspulse.demo',
      role: UserRole.student,
      subjects: ['DSA', 'ML'],
      goal: 'Placement preparation',
      availability: {'Saturday afternoon', 'Monday evening'},
    ),
    CampusUser(
      id: 'student-c',
      name: 'Student C',
      email: 'c@campuspulse.demo',
      role: UserRole.student,
      subjects: ['Web Dev', 'Design'],
      goal: 'Exam revision',
      availability: {'Saturday afternoon'},
    ),
  ];

  void _seed() {
    _events = [
      CampusEvent(
        id: 'hack-night',
        title: 'Campus Hack Night',
        category: 'Hackathon',
        description: 'Build a working prototype with your team in one evening.',
        organizer: 'Campus Innovation Club',
        venue: 'Lab 2',
        dateTime: DateTime(2026, 11, 1, 18),
        capacity: 50,
        registered: 26,
        tags: ['Web Dev', 'DSA'],
      ),
      CampusEvent(
        id: 'dsa-workshop',
        title: 'DSA Study Workshop',
        category: 'Workshop',
        description: 'Practice interview patterns with guided peer exercises.',
        organizer: 'Coding Club',
        venue: 'Hall B',
        dateTime: DateTime(2026, 11, 2, 11),
        capacity: 30,
        registered: 20,
        tags: ['DSA', 'Placement'],
      ),
      CampusEvent(
        id: 'open-mic',
        title: 'Open Mic Night',
        category: 'Clubs',
        description: 'An evening for music, poetry, and campus stories.',
        organizer: 'Arts Society',
        venue: 'Auditorium',
        dateTime: DateTime(2026, 11, 9, 18),
        capacity: 80,
        registered: 41,
        tags: ['Community'],
      ),
    ];
  }

  void _seedNotifications() {
    _notifications
      ..clear()
      ..addAll([
        CampusNotification(
          id: 'welcome',
          title: 'Welcome to Campus Pulse',
          body: 'Complete your profile to unlock better study-buddy matches.',
          createdAt: DateTime(2026, 10, 27, 16),
        ),
        CampusNotification(
          id: 'hack-night-reminder',
          title: 'Campus Hack Night is coming up',
          body: 'Registration is open in the Events tab.',
          createdAt: DateTime(2026, 10, 27, 12),
        ),
      ]);
  }

  @override CampusUser get currentUser => _user;
  @override bool get isAuthenticated => _authenticated;
  bool get serverConnected => _serverConnected;
  @override List<CampusEvent> get events => List.unmodifiable(_events);
  @override List<CampusUser> get candidates => List.unmodifiable(_candidates);
  @override Set<String> get bookmarkedEventIds => Set.unmodifiable(_bookmarks);
  @override List<MatchRequest> get matchRequests => List.unmodifiable(_requests);
  @override List<CampusConnection> get connections => List.unmodifiable(_connections);
  @override List<CampusNotification> get notifications => List.unmodifiable(_notifications);
  @override List<CampusMessage> messagesFor(String userId) => List.unmodifiable(
        _messages.where((message) =>
            message.senderId == _user.id && message.recipientId == userId ||
            message.senderId == userId && message.recipientId == _user.id)
          .toList()
        ..sort((a, b) => a.sentAt.compareTo(b.sentAt)),
      );

  @override Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    _client = remote.Client(AppConfig.serverUrl);
    try {
      final remoteEvents = await _client!.campus.listEvents();
      _events = remoteEvents.map((event) => CampusEvent(
        id: 'server-${event.id}',
        title: event.title,
        category: event.category,
        description: event.description,
        organizer: event.organizerId,
        venue: event.venue,
        dateTime: event.dateTime,
        capacity: event.capacity,
        registered: 0,
        tags: const [],
        cancelled: event.cancelled,
      )).toList();
      _serverConnected = true;
    } on Exception catch (error) {
      developer.log(
        'Campus Pulse server unavailable; using local demo data: $error',
        name: 'campus_pulse.repository',
      );
    }
    _authenticated = _preferences!.getBool('session.authenticated') ?? false;
    if (_authenticated && _preferences!.getString('session.email') == 'organizer@campuspulse.demo') {
      _user = const CampusUser(
        id: 'organizer-a', name: 'Campus Innovation Club',
        email: 'organizer@campuspulse.demo', role: UserRole.organizer,
      );
    }
    final subjects = _preferences!.getStringList('profile.subjects');
    final goal = _preferences!.getString('profile.goal');
    if (subjects != null || goal != null) {
      _user = CampusUser(
        id: _user.id, name: _user.name, email: _user.email, role: _user.role,
        subjects: subjects ?? _user.subjects, goal: goal ?? _user.goal,
        availability: _user.availability,
      );
    }

    _bookmarks.addAll(_preferences!.getStringList('bookmarks') ?? const []);
    _seedNotifications();
    for (final eventId in _preferences!.getStringList('registrations') ?? const []) {
      final index = _events.indexWhere((event) => event.id == eventId);
      if (index >= 0) {
        final event = _events[index];
        _events[index] = CampusEvent(
          id: event.id, title: event.title, category: event.category,
          description: event.description, organizer: event.organizer,
          venue: event.venue, dateTime: event.dateTime, capacity: event.capacity,
          registered: event.registered + 1, tags: event.tags,
        );
      }
    }
  }

  @override Future<void> signIn({required String email, required String password}) async {
    final isStudent = email == 'student@campuspulse.demo' && password == 'DemoStudent123!';
    final isOrganizer = email == 'organizer@campuspulse.demo' && password == 'DemoOrganizer123!';
    if (!isStudent && !isOrganizer) throw StateError('Invalid demo credentials');
    _authenticated = true;
    _user = isStudent
        ? const CampusUser(
            id: 'student-a', name: 'Student A', email: 'student@campuspulse.demo',
            role: UserRole.student, subjects: ['DSA', 'Web Dev'],
            goal: 'Placement preparation',
            availability: {'Saturday afternoon', 'Sunday morning'},
          )
        : const CampusUser(
            id: 'organizer-a', name: 'Campus Innovation Club',
            email: 'organizer@campuspulse.demo', role: UserRole.organizer,
          );
    await _preferences?.setBool('session.authenticated', true);
    await _preferences?.setString('session.email', email);
  }

  @override Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().length < 2) throw StateError('Enter your full name');
    if (!email.contains('@')) throw StateError('Enter a valid college email');
    if (password.length < 8) throw StateError('Password must be at least 8 characters');
    if (email == 'student@campuspulse.demo' || email == 'organizer@campuspulse.demo') {
      throw StateError('An account already exists for this email');
    }
    _authenticated = true;
    _user = CampusUser(
      id: 'local-${email.hashCode.abs()}',
      name: name.trim(),
      email: email.trim().toLowerCase(),
      role: UserRole.student,
    );
    await _preferences?.setBool('session.authenticated', true);
    await _preferences?.setString('session.email', _user.email);
  }

  @override Future<void> signOut() async {
    _authenticated = false;
    await _preferences?.setBool('session.authenticated', false);
  }

  @override Future<void> saveProfile({
    required List<String> subjects,
    required String goal,
    required Set<String> availability,
  }) async {
    _user = CampusUser(
      id: _user.id, name: _user.name, email: _user.email, role: _user.role,
      subjects: subjects, goal: goal, availability: availability,
    );
    await _preferences?.setStringList('profile.subjects', subjects);
    await _preferences?.setString('profile.goal', goal);
  }
  @override Future<void> toggleBookmark(String eventId) async {
    if (!_bookmarks.add(eventId)) _bookmarks.remove(eventId);
    await _preferences?.setStringList('bookmarks', _bookmarks.toList());
  }
  @override Future<void> register(String eventId) async {
    final index = _events.indexWhere((event) => event.id == eventId);
    if (index < 0) throw StateError('Event not found');
    final event = _events[index];
    if (event.cancelled || event.remainingSeats <= 0) {
      throw StateError('This event is no longer available');
    }
    final registrations = _preferences?.getStringList('registrations') ?? <String>[];
    if (registrations.contains(eventId)) {
      throw StateError('You are already registered for this event');
    }
    _events[index] = CampusEvent(
      id: event.id, title: event.title, category: event.category,
      description: event.description, organizer: event.organizer,
      venue: event.venue, dateTime: event.dateTime, capacity: event.capacity,
      registered: event.registered + 1, tags: event.tags,
    );
    registrations.add(eventId);
    await _preferences?.setStringList('registrations', registrations);
  }
  @override Future<void> sendMatchRequest(String userId) async {
    if (userId == _user.id || _requests.any((r) => r.toUserId == userId)) {
      throw StateError('A match request already exists');
    }
    _requests.add(MatchRequest(
      id: '${_user.id}-$userId', fromUserId: _user.id, toUserId: userId,
      status: MatchRequestStatus.pending,
    ));
    await requestConnection(userId);
  }

  @override Future<void> requestConnection(String userId) async {
    final candidate = _candidates.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw StateError('Student not found'),
    );
    if (_connections.any((connection) => connection.user.id == userId)) {
      throw StateError('A connection request already exists');
    }
    _connections.add(CampusConnection(
      user: candidate,
      status: ConnectionStatus.pending,
      incoming: false,
    ));
    _notifications.insert(
      0,
      CampusNotification(
        id: 'connection-$userId',
        title: 'Connection request sent',
        body: 'Your request to ${candidate.name} is pending.',
        createdAt: DateTime.now(),
      ),
    );
  }

  @override Future<void> updateConnection(String userId, ConnectionStatus status) async {
    final index = _connections.indexWhere((connection) => connection.user.id == userId);
    if (index < 0) throw StateError('Connection request not found');
    final connection = _connections[index];
    _connections[index] = CampusConnection(
      user: connection.user,
      status: status,
      incoming: connection.incoming,
    );
  }

  @override Future<void> markNotificationRead(String notificationId) async {
    final index = _notifications.indexWhere((notification) => notification.id == notificationId);
    if (index >= 0) _notifications[index] = _notifications[index].copyWith(read: true);
  }

  @override Future<void> markAllNotificationsRead() async {
    for (var index = 0; index < _notifications.length; index++) {
      _notifications[index] = _notifications[index].copyWith(read: true);
    }
  }

  @override Future<void> sendMessage(String userId, String body) async {
    final message = body.trim();
    if (message.isEmpty) throw StateError('Message cannot be empty');
    if (!_candidates.any((user) => user.id == userId)) {
      throw StateError('Student not found');
    }
    _messages.add(CampusMessage(
      id: '${_user.id}-${DateTime.now().microsecondsSinceEpoch}',
      senderId: _user.id,
      recipientId: userId,
      body: message,
      sentAt: DateTime.now(),
    ));
    final candidate = _candidates.firstWhere((user) => user.id == userId);
    _notifications.insert(
      0,
      CampusNotification(
        id: 'message-${DateTime.now().microsecondsSinceEpoch}',
        title: 'Message sent to ${candidate.name}',
        body: message,
        createdAt: DateTime.now(),
      ),
    );
  }
  @override Future<void> reset() async {
    _bookmarks.clear();
    _requests.clear();
    _connections.clear();
    _seedNotifications();
    _messages.clear();
    _seed();
    await _preferences?.clear();
  }
}
