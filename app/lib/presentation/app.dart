import 'package:flutter/material.dart';
import '../data/repository.dart';
import '../domain/models.dart';

const _blue = Color(0xff2451d8);
const _ink = Color(0xff13203a);
const _pale = Color(0xfff4f7fd);

class CampusPulseApp extends StatelessWidget {
  const CampusPulseApp({super.key, required this.repository});
  final CampusRepository repository;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Campus Pulse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: _blue),
          scaffoldBackgroundColor: _pale,
          fontFamily: 'Arial',
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
        home: AuthGate(repository: repository),
      );
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.repository});
  final CampusRepository repository;
  @override State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) => widget.repository.isAuthenticated
      ? HomeShell(repository: widget.repository)
      : LoginPage(repository: widget.repository, onSignedIn: () => setState(() {}));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.repository, required this.onSignedIn});
  final CampusRepository repository;
  final VoidCallback onSignedIn;
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController(text: 'student@campuspulse.demo');
  final _password = TextEditingController(text: 'DemoStudent123!');
  final _name = TextEditingController();
  String? _error;
  bool _registering = false;
  bool _busy = false;

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_registering) {
        await widget.repository.signUp(
          name: _name.text,
          email: _email.text.trim(),
          password: _password.text,
        );
      } else {
        await widget.repository.signIn(
          email: _email.text.trim(),
          password: _password.text,
        );
      }
      if (mounted) widget.onSignedIn();
    } catch (error) {
      if (mounted) setState(() => _error = error.toString().replaceFirst('Bad state: ', ''));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.hub, size: 64, color: _blue),
                  const SizedBox(height: 12),
                  const Text('Campus Pulse', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: _ink)),
                  const Text('Your campus, connected.', textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  if (_registering) ...[
                    TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline))),
                    const SizedBox(height: 12),
                  ],
                  TextField(controller: _email, decoration: const InputDecoration(labelText: 'College email', prefixIcon: Icon(Icons.email_outlined))),
                  const SizedBox(height: 12),
                  TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline))),
                  if (_error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_error!, style: const TextStyle(color: Colors.red))),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _busy ? null : _submit,
                    child: Text(_busy ? 'Please wait...' : _registering ? 'Create account' : 'Log in'),
                  ),
                  TextButton(
                    onPressed: _busy ? null : () => setState(() {
                      _registering = !_registering;
                      _error = null;
                    }),
                    child: Text(_registering ? 'Already have an account? Log in' : 'New to Campus Pulse? Create an account'),
                  ),
                  if (!_registering)
                    const Text('Demo student: student@campuspulse.demo\nDemo organizer: organizer@campuspulse.demo',
                        textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.repository});
  final CampusRepository repository;
  @override State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final unread = widget.repository.notifications.where((item) => !item.read).length;
    final pages = [
      FeedPage(repository: widget.repository, onChanged: _refresh),
      EventsPage(repository: widget.repository, onChanged: _refresh),
      CommunityPage(repository: widget.repository, onChanged: _refresh),
      ChatPage(repository: widget.repository, onChanged: _refresh),
      ProfilePage(repository: widget.repository, onChanged: _refresh),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      appBar: AppBar(
        title: const Text('Campus Pulse', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Stack(
            children: [
              IconButton(
                tooltip: 'Notifications',
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(
                    builder: (_) => NotificationsPage(repository: widget.repository),
                  ));
                  _refresh();
                },
                icon: const Icon(Icons.notifications_none),
              ),
              if (unread > 0) Positioned(
                right: 7, top: 7,
                child: CircleAvatar(radius: 8, backgroundColor: Colors.red,
                    child: Text('$unread', style: const TextStyle(fontSize: 9, color: Colors.white))),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Community'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.repository, required this.onChanged});
  final CampusRepository repository; final VoidCallback onChanged;
  @override State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String _query = '';
  @override
  Widget build(BuildContext context) {
    final events = widget.repository.events.where((event) =>
        event.title.toLowerCase().contains(_query.toLowerCase()) ||
        event.tags.any((tag) => tag.toLowerCase().contains(_query.toLowerCase()))).toList();
    return ListView(padding: const EdgeInsets.all(20), children: [
      Text('Good to see you, ${widget.repository.currentUser.name.split(' ').first}', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _ink)),
      const SizedBox(height: 6),
      const Text('Discover what is happening around campus.'),
      const SizedBox(height: 18),
      TextField(onChanged: (value) => setState(() => _query = value), decoration: const InputDecoration(hintText: 'Search events, clubs and topics', prefixIcon: Icon(Icons.search))),
      const SizedBox(height: 20),
      const Text('Upcoming on campus', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _ink)),
      ...events.map((event) => EventCard(event: event, repository: widget.repository, onChanged: widget.onChanged)),
      if (events.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No events match your search.'))),
    ]);
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, required this.repository, required this.onChanged});
  final CampusEvent event; final CampusRepository repository; final VoidCallback onChanged;
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(top: 12),
        child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(event.category.toUpperCase(), style: const TextStyle(color: _blue, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 5),
          Text(event.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _ink)),
          Text('${event.dateTime.day} Nov · ${event.venue} · ${event.remainingSeats} seats left', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8), Text(event.description),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: FilledButton(onPressed: event.remainingSeats <= 0 ? null : () async {
              try { await repository.register(event.id); onChanged(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration confirmed'))); }
              catch (error) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error'))); }
            }, child: const Text('Register'))),
            IconButton(onPressed: () async { await repository.toggleBookmark(event.id); onChanged(); },
                icon: Icon(repository.bookmarkedEventIds.contains(event.id) ? Icons.bookmark : Icons.bookmark_border)),
          ]),
        ])));
}

class EventsPage extends StatelessWidget {
  const EventsPage({super.key, required this.repository, required this.onChanged});
  final CampusRepository repository; final VoidCallback onChanged;
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('My events', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _ink)),
    const SizedBox(height: 12),
    ...repository.events.map((event) => Card(child: ListTile(
      leading: const CircleAvatar(backgroundColor: Color(0xffe7edfb), child: Icon(Icons.event, color: _blue)),
      title: Text(event.title), subtitle: Text('${event.registered}/${event.capacity} registered · ${event.organizer}'),
      trailing: Icon(repository.bookmarkedEventIds.contains(event.id) ? Icons.bookmark : Icons.chevron_right),
    ))),
  ]);
}

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key, required this.repository, required this.onChanged});
  final CampusRepository repository; final VoidCallback onChanged;
  @override State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String _query = '';
  @override Widget build(BuildContext context) {
    final users = widget.repository.candidates.where((user) =>
        user.name.toLowerCase().contains(_query.toLowerCase()) ||
        user.subjects.any((subject) => subject.toLowerCase().contains(_query.toLowerCase()))).toList();
    return ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Student directory', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _ink)),
      const Text('Find classmates by name, subjects and goals.'),
      const SizedBox(height: 14),
      TextField(onChanged: (value) => setState(() => _query = value), decoration: const InputDecoration(hintText: 'Search students or skills', prefixIcon: Icon(Icons.search))),
      const SizedBox(height: 10),
      ...users.map((user) => Card(child: ListTile(
        leading: CircleAvatar(backgroundColor: _blue, child: Text(user.name.substring(0, 1), style: const TextStyle(color: Colors.white))),
        title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${user.subjects.join(' · ')}\n${user.goal}'),
        isThreeLine: true,
        trailing: IconButton(icon: const Icon(Icons.person_add_alt_1), onPressed: () async {
          try { await widget.repository.requestConnection(user.id); widget.onChanged(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connection request sent'))); }
          catch (error) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error'))); }
        }),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(repository: widget.repository, user: user, onChanged: widget.onChanged))),
      ))),
    ]);
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.repository, required this.onChanged, this.user});
  final CampusRepository repository; final VoidCallback onChanged; final CampusUser? user;
  @override State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _message = TextEditingController();
  CampusUser? _selected;
  @override void initState() { super.initState(); _selected = widget.user; }
  @override Widget build(BuildContext context) {
    final selected = _selected;
    if (selected == null) {
      return ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Messages', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _ink)),
        const SizedBox(height: 10), const Text('Start a conversation from the student directory.'),
        ...widget.repository.connections.where((connection) => connection.status == ConnectionStatus.connected).map((connection) => ListTile(
          leading: CircleAvatar(child: Text(connection.user.name.substring(0, 1))), title: Text(connection.user.name),
          onTap: () => setState(() => _selected = connection.user),
        )),
        if (widget.repository.connections.isEmpty) const Padding(padding: EdgeInsets.all(30), child: Text('No conversations yet. Explore the directory to connect.')),
      ]);
    }
    final messages = widget.repository.messagesFor(selected.id);
    return Column(children: [
      ListTile(leading: const BackButton(), title: Text(selected.name, style: const TextStyle(fontWeight: FontWeight.bold))),
      Expanded(child: messages.isEmpty
          ? const Center(child: Text('Start the conversation'))
          : ListView(padding: const EdgeInsets.all(16), children: messages.map((message) => Align(
              alignment: message.senderId == widget.repository.currentUser.id ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: message.senderId == widget.repository.currentUser.id ? _blue : Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Text(message.body, style: TextStyle(color: message.senderId == widget.repository.currentUser.id ? Colors.white : _ink)),
              ),
            )).toList())),
      SafeArea(child: Padding(padding: const EdgeInsets.all(10), child: Row(children: [
        Expanded(child: TextField(controller: _message, decoration: const InputDecoration(hintText: 'Write a message...'))),
        IconButton(icon: const Icon(Icons.send, color: _blue), onPressed: () async {
          try { await widget.repository.sendMessage(selected.id, _message.text); _message.clear(); setState(() {}); widget.onChanged(); }
          catch (error) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error'))); }
        }),
      ]))),
    ]);
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key, required this.repository});
  final CampusRepository repository;
  @override State<NotificationsPage> createState() => _NotificationsPageState();
}
class _NotificationsPageState extends State<NotificationsPage> {
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifications'), actions: [
      TextButton(onPressed: () async { await widget.repository.markAllNotificationsRead(); setState(() {}); }, child: const Text('Mark all read')),
    ]),
    body: ListView(padding: const EdgeInsets.all(16), children: widget.repository.notifications.map((item) => Card(
      color: item.read ? Colors.white : const Color(0xffe7edfb),
      child: ListTile(title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(item.body),
        onTap: () async { await widget.repository.markNotificationRead(item.id); setState(() {}); }),
    )).toList()),
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.repository, required this.onChanged});
  final CampusRepository repository; final VoidCallback onChanged;
  @override State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  late Set<String> _subjects;
  late String _goal;
  @override void initState() { super.initState(); _subjects = widget.repository.currentUser.subjects.toSet(); _goal = widget.repository.currentUser.goal; }
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Text('Your profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: _ink)),
    const SizedBox(height: 6), Text(widget.repository.currentUser.name, style: const TextStyle(fontSize: 18)),
    Text(widget.repository.currentUser.email, style: const TextStyle(color: Colors.grey)),
    const SizedBox(height: 22), const Text('Subjects and interests', style: TextStyle(fontWeight: FontWeight.bold)),
    Wrap(spacing: 8, children: ['DSA', 'Web Dev', 'ML', 'Design', 'Electronics'].map((subject) => FilterChip(
      label: Text(subject), selected: _subjects.contains(subject),
      onSelected: (value) => setState(() => value ? _subjects.add(subject) : _subjects.remove(subject)),
    )).toList()),
    const SizedBox(height: 12), TextFormField(initialValue: _goal, decoration: const InputDecoration(labelText: 'Learning goal'), onChanged: (value) => _goal = value),
    const SizedBox(height: 16), FilledButton(onPressed: () async {
      await widget.repository.saveProfile(subjects: _subjects.toList(), goal: _goal, availability: widget.repository.currentUser.availability);
      widget.onChanged(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
    }, child: const Text('Save profile')),
    const SizedBox(height: 12), OutlinedButton(onPressed: () async { await widget.repository.signOut(); if (context.mounted) Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => AuthGate(repository: widget.repository)), (_) => false); }, child: const Text('Sign out')),
  ]);
}
