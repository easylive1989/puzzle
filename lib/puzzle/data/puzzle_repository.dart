
import 'package:puzzle/puzzle/domain/entity/puzzle.dart';

abstract interface class PuzzleRepository {
  Future<List<Puzzle>> getAll();

  Future<Puzzle> get(int id);

  Future<void> save(Puzzle puzzle);

  Future<int> create(Puzzle puzzle);
}
