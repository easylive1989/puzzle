import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/dependency_providers.dart';
import 'package:puzzle/my_app.dart';
import 'package:http/http.dart' as http;
import 'package:puzzle/puzzle/data/source/app_database.dart';

import 'package:puzzle/puzzle/domain/tiles_generator.dart';

import 'app_test_utils.dart';


late _MockRandomGenerator _randomGenerator;
main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  AppDatabase database = AppDatabase();

  setUp(() async {
    _randomGenerator = _MockRandomGenerator();
    await deleteAccounts();
    await database.puzzleGames.deleteAll();
  });

  testWidgets("play puzzle", (tester) async {
    _givenRandomNumberList([1, 2, 3, 4, 5, 6, 7, 0, 8]);

    await _openApp(tester, database);

    await _createNumberPuzzle(tester);

    await _openGame(tester, 1);

    await _moveTile(tester, "8");

    await _shouldShow(tester, l10n.finish_game);
  });
}

Future<void> _shouldShow(WidgetTester tester, String text) async {
  await tester.pumpUntilFound(find.text(text));
  expect(find.text(l10n.finish_game), findsOneWidget);
}

Future<void> _moveTile(WidgetTester tester, String tile) async {
  await tester.pumpUntilFound(find.text(tile));
  await tester.tap(find.text(tile));
}

Future<void> _openGame(WidgetTester tester, int id) async {
  await tester.pumpUntilFound(find.textContaining(l10n.number_game_title(id)));
  await tester.tap(find.textContaining(l10n.number_game_title(id)));
}

Future<void> _createNumberPuzzle(WidgetTester tester) async {
  await tester.pumpUntilFound(find.text(l10n.number));
  await tester.tap(find.text(l10n.number));
}

Future<void> _openApp(WidgetTester tester, AppDatabase database) async {
  await tester.pumpWidget(MultiProvider(
    providers: DependencyProviders.get(
      database: database,
      randomGenerator: _randomGenerator,
    ),
    child: const MyApp(),
  ));
}

void _givenRandomNumberList(List<int> randomNumberList) {
  when(() => _randomGenerator.generate(any())).thenReturn(randomNumberList);
}

class _MockRandomGenerator extends Mock implements TilesGenerator {}

Future<void> deleteAccounts() async {
  await http.delete(Uri.parse(
      'http://$localhost:9099/emulator/v1/projects/puzzle-9e8c6/accounts'));
}
