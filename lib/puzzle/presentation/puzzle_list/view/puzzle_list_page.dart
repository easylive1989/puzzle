import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/authentication/domain/authentication_repository.dart';
import 'package:puzzle/authentication/presentation/login/bloc/authentication_cubit.dart';
import 'package:puzzle/gen/assets.gen.dart';
import 'package:puzzle/puzzle/domain/get_ongoing_puzzles_use_case.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/domain/create_puzzle_use_case.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_info.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/game_list_tile.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/new_game_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PuzzleListPage extends StatelessWidget {
  static String route = "/list";

  const PuzzleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PuzzleListCubit>(
          create: (context) => PuzzleListCubit(
            context.read<GetOngoingPuzzlesUseCase>(),
            context.read<CreatePuzzleUseCase>(),
          )..load(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
      ],
      child: const PuzzleListView(),
    );
  }
}

class PuzzleListView extends StatelessWidget {
  const PuzzleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushReplacementNamed("/");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () => context.read<AuthenticationCubit>().logout(),
                icon: const Icon(Icons.logout),
              );
            }),
          ],
        ),
        body: BlocBuilder<PuzzleListCubit, PuzzleListState>(
          builder: (context, state) {
            if (state.status != PuzzleListStatus.loaded) {
              return const Center(child: CircularProgressIndicator());
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.puzzleInfos.isEmpty) const _NoPuzzlesGamesView(),
                  if (state.puzzleInfos.isNotEmpty)
                    _PuzzleGameListView(puzzleInfos: state.puzzleInfos),
                  const SizedBox(height: 24),
                  const NewGameButton(),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      launchUrl(
                          Uri.parse("https://en.wikipedia.org/wiki/15_puzzle"));
                    },
                    child: Text(AppLocalizations.of(context)!.what_is_n_puzzle),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PuzzleGameListView extends StatelessWidget {
  const _PuzzleGameListView({
    required this.puzzleInfos,
  });

  final List<PuzzleInfo> puzzleInfos;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.3,
      width: MediaQuery.sizeOf(context).width * 0.5,
      color: Colors.grey,
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: const ClampingScrollPhysics(),
        itemCount: puzzleInfos.length,
        itemBuilder: (context, index) {
          return GameListTile(
            name: puzzleInfos[index],
          );
        },
      ),
    );
  }
}

class _NoPuzzlesGamesView extends StatelessWidget {
  const _NoPuzzlesGamesView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.no_ongoing_game,
          style: const TextStyle(fontSize: 20),
        ),
        Assets.emptyPuzzle.image(
          width: MediaQuery.sizeOf(context).width * 0.5,
          height: MediaQuery.sizeOf(context).height * 0.5,
        ),
      ],
    );
  }
}
