import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/puzzle_bloc.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/current_puzzle.dart';

late PuzzleRepository _puzzleRepository;
late PuzzleBloc _puzzleBloc;

main() {
  setUp(() {
    _puzzleRepository = MockPuzzleRepository();
    _puzzleBloc = PuzzleBloc(_puzzleRepository);
  });

  test("puzzle cubit stream test", () async {
    _givenPuzzle(Puzzle(
      id: 1,
      type: PuzzleType.number,
      tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
      createdAt: DateTime.parse("2024-06-01"),
      updatedAt: DateTime.parse("2024-06-01"),
    ));

    _puzzleBloc.add(LoadPuzzle(1));

    expect(
        _puzzleBloc.stream,
        emits(
          PuzzleState(
            status: PuzzleStatus.loaded,
            puzzle: CurrentPuzzle(
              id: 1,
              type: PuzzleType.number,
              tiles: const [1, 2, 3, 4, 5, 6, 7, 8, 0],
              isGameOver: true,
              createdAt: DateTime.parse("2024-06-01"),
              updatedAt: DateTime.parse("2024-06-01"),
              size: 3,
            ),
          ),
        ));
  });
}

void _givenPuzzle(Puzzle puzzle) {
  when(() => _puzzleRepository.get(any())).thenAnswer((_) async {
    return puzzle;
  });
}

class MockPuzzleRepository extends Mock implements PuzzleRepository {}
