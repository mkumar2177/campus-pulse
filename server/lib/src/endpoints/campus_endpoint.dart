import 'package:serverpod/serverpod.dart';
import '../generated/campus_event.dart';

class CampusEndpoint extends Endpoint {
  Future<String> health(Session session) async => 'Campus Pulse backend ready';

  Future<List<CampusEvent>> listEvents(Session session) {
    return session.db.find<CampusEvent>(
      where: CampusEvent.t.cancelled.equals(false),
    );
  }
}
