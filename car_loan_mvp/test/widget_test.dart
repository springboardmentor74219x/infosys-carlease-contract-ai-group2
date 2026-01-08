import 'package:flutter_test/flutter_test.dart';
import 'package:car_loan_mvp/main.dart';

void main() {
  testWidgets('App loads Login screen', (WidgetTester tester) async {
    await tester.pumpWidget(CarLoanApp());

    // Verify Login screen text
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
