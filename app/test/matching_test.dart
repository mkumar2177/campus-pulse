import 'package:flutter_test/flutter_test.dart';
import 'package:campus_pulse/domain/matching.dart';
import 'package:campus_pulse/domain/models.dart';

void main() {
  const source = CampusUser(
    id: 'a', name: 'A', email: 'a@example.com', role: UserRole.student,
    subjects: ['DSA', 'Web Dev'], goal: 'Placement',
    availability: {'Saturday afternoon', 'Sunday morning'},
  );
  test('calculates weighted score from components', () {
    const candidate = CampusUser(
      id: 'b', name: 'B', email: 'b@example.com', role: UserRole.student,
      subjects: ['DSA'], goal: 'Placement',
      availability: {'Saturday afternoon'},
    );
    final result = calculateMatch(source, candidate);
    expect(result.totalScore, 65);
    expect(result.reasons, contains('You both study DSA'));
  });
  test('does not invent compatibility for missing profile data', () {
    const candidate = CampusUser(
      id: 'b', name: 'B', email: 'b@example.com', role: UserRole.student,
    );
    expect(calculateMatch(source, candidate).totalScore, 0);
  });
}
