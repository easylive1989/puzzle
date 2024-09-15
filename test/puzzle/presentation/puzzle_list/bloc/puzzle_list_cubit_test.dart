import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle/puzzle/domain/get_ongoing_puzzles_use_case.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/domain/create_puzzle_use_case.dart';

import '../../../domain/entity/puzzle_factory.dart';

late MockGetOngoingPuzzlesUseCase _puzzleListUseCase;
late MockCreatePuzzleUseCase _createPuzzleUseCase;
late PuzzleListCubit _puzzleListCubit;

main() {
  setUp(() {
    _puzzleListUseCase = MockGetOngoingPuzzlesUseCase();
    _createPuzzleUseCase = MockCreatePuzzleUseCase();
    _puzzleListCubit = PuzzleListCubit(
      _puzzleListUseCase,
      _createPuzzleUseCase,
    );
  });

  test("create puzzle", () async {
    _givenCreateOk();

    await _puzzleListCubit.create(PuzzleType.number);

    verify(() => _createPuzzleUseCase.create(PuzzleType.number)).called(1);
  });

  test("puzzle list init", () {
    expect(
      _puzzleListCubit.state,
      equals(const PuzzleListState(
        status: PuzzleListStatus.initial,
        puzzleInfos: [],
      )),
    );
  });

  test("puzzle list loaded", () async {
    _givenPuzzleList([
      puzzle(id: 2, type: PuzzleType.number),
    ]);

    await _puzzleListCubit.load();

    expect(
      _puzzleListCubit.state,
      equals(const PuzzleListState(
        status: PuzzleListStatus.loaded,
        puzzleInfos: [PuzzleInfo(id: 2, type: PuzzleType.number)],
      )),
    );
  });
}

void _givenCreateOk() {
  when(() => _createPuzzleUseCase.create(PuzzleType.number))
      .thenAnswer((_) async => 1);
}

void _givenPuzzleList(List<Puzzle> list) {
  when(() => _puzzleListUseCase.get()).thenAnswer((invocation) async {
    return list;
  });
}

class MockGetOngoingPuzzlesUseCase extends Mock
    implements GetOngoingPuzzlesUseCase {}

class MockCreatePuzzleUseCase extends Mock implements CreatePuzzleUseCase {}
