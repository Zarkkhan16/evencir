import 'package:evencir_app/app/app.dart';
import 'package:evencir_app/app/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await sl.reset();
    await configureDependencies();
  });

  testWidgets('App renders nutrition dashboard', (tester) async {
    await tester.pumpWidget(const EvencirApp());
    await tester.pumpAndSettle();

    expect(find.text('Nutrition'), findsOneWidget);
    expect(find.text('Workouts'), findsOneWidget);
    expect(find.text('Upper Body'), findsOneWidget);
  });

  testWidgets('Bottom nav switches to mood tab', (tester) async {
    await tester.pumpWidget(const EvencirApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mood'));
    await tester.pumpAndSettle();

    expect(find.text('Continue'), findsOneWidget);
    expect(find.textContaining('How are you feeling'), findsOneWidget);
  });
}
