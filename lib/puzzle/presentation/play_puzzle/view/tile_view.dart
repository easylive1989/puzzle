import 'package:flutter/material.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';

class TileView extends StatelessWidget {
  const TileView({
    super.key,
    required this.tile,
    required this.puzzleTileSize,
    required this.puzzleType,
    required this.onTap,
  });

  final int tile;
  final PuzzleType puzzleType;
  final double puzzleTileSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: tile != 0
          ? _TileView(
              puzzleTileSize: puzzleTileSize,
              child: puzzleType == PuzzleType.number
                  ? Text(
                      tile.toString(),
                      style: const TextStyle(fontSize: 24),
                    )
                  : Image.asset(
                      "assets/puzzle_img_$tile.jpg",
                      fit: BoxFit.fill,
                    ),
            )
          : const SizedBox(),
    );
  }
}

class _TileView extends StatelessWidget {
  const _TileView({
    required this.puzzleTileSize,
    required this.child,
  });

  final double puzzleTileSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: puzzleTileSize,
      height: puzzleTileSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: child,
    );
  }
}
