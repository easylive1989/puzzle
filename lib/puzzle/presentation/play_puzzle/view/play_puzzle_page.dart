import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/move_tile_bloc.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/puzzle_bloc.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/leave_button.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/playing_time_view.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/tile_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayPuzzlePage extends StatefulWidget {
  static String route = "/game";

  const PlayPuzzlePage({super.key, required this.id});

  final int id;

  @override
  State<PlayPuzzlePage> createState() => _PlayPuzzlePageState();
}

class _PlayPuzzlePageState extends State<PlayPuzzlePage> {
  int? lastMovedTile;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoveTileBloc>(
          create: (context) => MoveTileBloc(context.read()),
        ),
        BlocProvider<PuzzleBloc>(
          create: (context) =>
              PuzzleBloc(context.read())..add(LoadPuzzle(widget.id)),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: BlocListener<MoveTileBloc, MoveTileState>(
            listener: (context, state) {
              _onMoveStateChange(context, state);
            },
            child: BlocBuilder<PuzzleBloc, PuzzleState>(
              builder: (context, state) => _buildPuzzle(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPuzzle(BuildContext context, PuzzleState state) {
    if (state.status != PuzzleStatus.loaded) {
      return const CircularProgressIndicator();
    }

    const puzzleTileSize = 90.0;
    var puzzle = state.puzzle!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlayingTimeView(puzzle: puzzle),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            context.read<MoveTileBloc>().add(MoveTile(
                  id: widget.id,
                  tile: lastMovedTile!,
                ));
          },
          child: const Icon(Icons.undo),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all()),
          width: puzzleTileSize * puzzle.size,
          height: puzzleTileSize * puzzle.size,
          child: Stack(
            children: [
              for (var tile in puzzle.sortedPositionedTiles)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: tile.row * puzzleTileSize,
                  left: tile.column * puzzleTileSize,
                  child: TileView(
                    tile: tile.value,
                    puzzleType: puzzle.type,
                    puzzleTileSize: puzzleTileSize,
                    onTap: () {
                      context
                        .read<MoveTileBloc>()
                        .add(MoveTile(id: widget.id, tile: tile.value));
                      lastMovedTile = tile.value;
                    },
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        LeaveButton(isGameOver: puzzle.isGameOver),
      ],
    );
  }

  void _onMoveStateChange(BuildContext context, MoveTileState state) {
    if (state.status == MoveTileStatus.fail) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context)!.move_tile_error,
      )));
    } else {
      context.read<PuzzleBloc>().add(LoadPuzzle(widget.id));
    }
  }
}
