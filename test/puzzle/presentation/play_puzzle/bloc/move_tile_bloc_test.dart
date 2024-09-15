import 'package:flutter_test/flutter_test.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/move_tile_bloc.dart';

import '../../../domain/entity/puzzle_factory.dart';

late MoveTileBloc _moveTileBloc;
late FakePuzzleRepository _fakePuzzleRepository;

main() {
  setUp(() {
    _fakePuzzleRepository = FakePuzzleRepository();
    final moveTileUseCase = MoveTileUseCase(_fakePuzzleRepository);
    _moveTileBloc = MoveTileBloc(moveTileUseCase);
  });

  test("move puzzle", () {
    _givenPuzzle(puzzle(id: 1, tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8]));

    _whenMove(id: 1, tile: 8);

    expect(
      _moveTileBloc.stream,
      emits(moveTileState(MoveTileStatus.success)),
    );
  });

  test("move fail", () {
    _givenPuzzle(puzzle(
      id: 1,
      tiles: [1, 2, 3, 4, 5, 6, 7, 0, 8],
    ));

    _whenMove(id: 1, tile: 1);

    expect(
      _moveTileBloc.stream,
      emits(moveTileState(MoveTileStatus.fail)),
    );

  });
}

Matcher moveTileState(MoveTileStatus status) {
  return isA<MoveTileState>().having((e) => e.status, "status", equals(status));
}

void _whenMove({required int id, required int tile}) {
  _moveTileBloc.add(MoveTile(id: id, tile: tile));
}

void _givenPuzzle(Puzzle puzzle) {
  _fakePuzzleRepository.save(puzzle);
}

class FakePuzzleRepository extends Fake implements PuzzleRepository {
  late Puzzle puzzle;

  FakePuzzleRepository();

  @override
  Future<int> save(Puzzle puzzle) async {
    this.puzzle = puzzle;
    return 0;
  }

  @override
  Future<Puzzle> get(int id) async {
    return puzzle;
  }
}
