import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';

class GameListTile extends StatelessWidget {
  const GameListTile({
    super.key,
    required this.name,
  });

  final PuzzleInfo name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var puzzleListCubit = context.read<PuzzleListCubit>();
        var isFinish = await Navigator.of(context).pushNamed(
          "/game",
          arguments: name.id,
        );
        if (isFinish == true) {
          puzzleListCubit.load();
        }
      },
      child: Container(
        width: MediaQuery
            .sizeOf(context)
            .width * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
        ),
        child: Text(
          switch (name.type) {
            PuzzleType.number => AppLocalizations.of(context)!.number_game_title(name. id),
          PuzzleType.image => AppLocalizations.of(context)!.image_game_title(name.id),
          },
        ),
      ),
    );
  }
}
