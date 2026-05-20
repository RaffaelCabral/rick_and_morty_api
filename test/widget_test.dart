import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/src/modules/core/di/service_locator.dart';

import 'package:rick_and_morty_api/main.dart';

void main() {
  setUpAll(() async {
    await setupDependencies();
  });

  testWidgets('renders home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('The Chaos Archive'), findsOneWidget);
    expect(find.text('Buscar por episódio'), findsOneWidget);
    expect(find.text('Número do episódio'), findsOneWidget);
  });
}
