import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/puzzle_list_page.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../../widget_test_utils.dart';

late MocUrlLauncherPlatform _urlLauncherPlatform;
late PuzzleListCubit _puzzleListCubit;

main() {
  setUp(() {
    registerFallbackValue(PuzzleType.number);
    registerFallbackValue(const LaunchOptions());
    UrlLauncherPlatform.instance =
        _urlLauncherPlatform = MocUrlLauncherPlatform();
    _puzzleListCubit = MockPuzzleListCubit();
  });

  testWidgets("creat new number game", (tester) async {
    _givenCreatePuzzleOk();
    _givenPuzzleInfoList([]);

    await _givenPuzzleListView(tester);

    await tester.tap(find.text(l10n.number));
    await tester.pump();

    verify(() => _puzzleListCubit.create(PuzzleType.number)).called(1);
    expect(find.text(l10n.create_success), findsOneWidget);
  });

  testWidgets("creat new image game", (tester) async {
    _givenCreatePuzzleOk();
    _givenPuzzleInfoList([]);

    await _givenPuzzleListView(tester);

    await tester.tap(find.text(l10n.image));

    verify(() => _puzzleListCubit.create(PuzzleType.image)).called(1);

    tester.binding.delayed(const Duration(seconds: 3));
  });

  testWidgets("when game list has game 1", (tester) async {
    _givenPuzzleInfoList([
      const PuzzleInfo(id: 1, type: PuzzleType.number),
    ]);

    await _givenPuzzleListView(tester);

    expect(find.text(l10n.number_game_title(1)), findsOneWidget);
  });

  testWidgets("show no game found when there is no game", (tester) async {
    _givenPuzzleInfoList([]);

    await _givenPuzzleListView(tester);

    expect(find.text(l10n.no_ongoing_game), findsOneWidget);
  });

  testWidgets("open puzzle link", (tester) async {
    _givenPuzzleInfoList([]);
    _givenLaunchUrlOk();

    await _givenPuzzleListView(tester);

    await tester.tap(find.text(l10n.what_is_n_puzzle));

    verify(() => _urlLauncherPlatform.launchUrl(
        "https://en.wikipedia.org/wiki/15_puzzle", any()));
  });
}

void _givenLaunchUrlOk() {
  when(() => _urlLauncherPlatform.launchUrl(any(), any()))
      .thenAnswer((invocation) async => true);
}

Future<void> _givenPuzzleListView(WidgetTester tester) async {
  await tester.givenView(BlocProvider<PuzzleListCubit>.value(
    value: _puzzleListCubit,
    child: const PuzzleListView(),
  ));
}

void _givenCreatePuzzleOk() {
  when(() => _puzzleListCubit.create(any())).thenAnswer((_) async {});
}

void _givenPuzzleInfoList(List<PuzzleInfo> puzzleInfos) {
  when(() => _puzzleListCubit.stream).thenAnswer((_) => const Stream.empty());
  when(() => _puzzleListCubit.state).thenReturn(PuzzleListState(
    status: PuzzleListStatus.loaded,
    puzzleInfos: puzzleInfos,
  ));
}

class MockPuzzleListCubit extends Mock implements PuzzleListCubit {}

class MocUrlLauncherPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}
