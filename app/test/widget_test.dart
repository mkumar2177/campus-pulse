import 'package:campus_pulse/data/local_repository.dart';
import 'package:campus_pulse/presentation/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Campus Pulse login screen', (tester) async {
    await tester.pumpWidget(CampusPulseApp(repository: LocalRepository()));
    expect(find.text('Campus Pulse'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
