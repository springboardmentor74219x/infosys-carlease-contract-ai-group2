import 'package:flutter_test/flutter_test.dart';
import 'package:car_loan_mvp/main.dart';

void main() {
  testWidgets('App loads Upload screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify Upload screen UI
    expect(find.text('Upload Contract'), findsOneWidget);
    expect(find.text('Pick Contract (PDF/Image)'), findsOneWidget);
    expect(find.text('Upload'), findsOneWidget);
  });
}
