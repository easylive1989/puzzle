import 'package:provider/provider.dart';
import 'package:puzzle/puzzle/data/puzzle_repository.dart';
import 'package:puzzle/puzzle/data/source/app_database.dart';
import 'package:puzzle/puzzle/data/puzzle_db_repository.dart';
import 'package:puzzle/puzzle/data/random_tiles_generator.dart';
import 'package:puzzle/puzzle/domain/create_puzzle_use_case.dart';
import 'package:puzzle/puzzle/domain/get_ongoing_puzzles_use_case.dart';
import 'package:puzzle/puzzle/domain/move_tile_use_case.dart';
import 'package:puzzle/puzzle/domain/tiles_generator.dart';

class DependencyProviders {
  static List<Provider> get({
    TilesGenerator? randomGenerator,
    AppDatabase? database,
  }) {
    final appDatabase = database ?? AppDatabase();
    final puzzleDbRepository = PuzzleDbRepository(appDatabase.puzzleGamesDao);
    final moveTileUseCase = MoveTileUseCase(puzzleDbRepository);
    final getOngoingPuzzlesUseCase = GetOngoingPuzzlesUseCase(
      puzzleDbRepository,
    );
    final createPuzzleUseCase = CreatePuzzleUseCase(
      puzzleDbRepository,
      randomGenerator ?? RandomTilesGenerator(),
    );

    return [
      Provider(
        create: (context) => database,
        dispose: (context, database) => database.close(),
      ),
      Provider<MoveTileUseCase>.value(value: moveTileUseCase),
      Provider<GetOngoingPuzzlesUseCase>.value(value: getOngoingPuzzlesUseCase),
      Provider<CreatePuzzleUseCase>.value(value: createPuzzleUseCase),
      Provider<PuzzleRepository>.value(value: puzzleDbRepository),
    ];
  }
}
