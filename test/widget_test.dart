import 'package:flutter_test/flutter_test.dart';
import 'package:loksewa_prep_app/app.dart';

void main() {
  testWidgets('LokSewaApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LokSewaApp());
    expect(find.text('LokSewa Prep'), findsWidgets);
  });
}
