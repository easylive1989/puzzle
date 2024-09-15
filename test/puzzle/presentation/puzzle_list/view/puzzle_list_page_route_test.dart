import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/puzzle_list_page.dart';

import '../../../../route_matcher.dart';
import '../../../../widget_test_utils.dart';

late PuzzleListCubit _puzzleListCubit;
late MockNavigatorObserver _navigatorObserver;

main() {
  setUp(() {
    registerFallbackValue(MockRoute());
    _navigatorObserver = MockNavigatorObserver();
    _puzzleListCubit = MockPuzzleListCubit();
  });

  testWidgets("navigator to game 1", (tester) async {
    _givenPuzzleList([
      const PuzzleInfo(id: 1, type: PuzzleType.number),
    ]);

    await _givenPuzzleListView(tester);

    await _whenTap(tester, find.text(l10n.number_game_title(1)));

    _thenRouteShouldBe(isRoute(routeName: "/game", arguments: 1));
  });

  testWidgets("navigator back from play puzzle", (tester) async {
    _givenLoadOk();
    _givenPuzzleList([
      const PuzzleInfo(id: 1, type: PuzzleType.number),
    ]);

    GlobalKey<NavigatorState> navigatorKey = GlobalKey();

    await _givenPuzzleListView(tester, navigatorKey: navigatorKey);

    await _whenTap(tester, find.text(l10n.number_game_title(1)));

    await _back(tester, navigatorKey, true);

    verify(() => _puzzleListCubit.load()).called(1);
  });
}

Future<void> _back(
  WidgetTester tester,
  GlobalKey<NavigatorState> navigatorKey,
  bool result,
) async {
  navigatorKey.currentState?.pop(result);
  await tester.pump();
}

void _givenLoadOk() {
  when(() => _puzzleListCubit.load()).thenAnswer((_) async {});
}

void _givenPuzzleList(List<PuzzleInfo> puzzleInfos) {
  when(() => _puzzleListCubit.stream).thenAnswer((_) => const Stream.empty());
  when(() => _puzzleListCubit.state).thenReturn(PuzzleListState(
    status: PuzzleListStatus.loaded,
    puzzleInfos: puzzleInfos,
  ));
}

void _thenRouteShouldBe(RouteMatcher routeMatcher) {
  verify(() => _navigatorObserver.didPush(
        any(that: routeMatcher),
        any(),
      ));
}

Future<void> _whenTap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump();
}

Future<void> _givenPuzzleListView(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await tester.givenView(
    BlocProvider<PuzzleListCubit>.value(
      value: _puzzleListCubit,
      child: const PuzzleListView(),
    ),
    navigatorObservers: [_navigatorObserver],
    navigatorKey: navigatorKey,
  );
  await tester.pump();
}

class MockPuzzleListCubit extends Mock implements PuzzleListCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route {}
