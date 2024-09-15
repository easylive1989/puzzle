import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/bloc/puzzle_list_cubit.dart';
import 'package:puzzle/puzzle/domain/entity/puzzle_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewGameButton extends StatefulWidget {
  const NewGameButton({super.key});

  @override
  State<NewGameButton> createState() => _NewGameButtonState();
}

class _NewGameButtonState extends State<NewGameButton> {
  bool _isCreateSuccessMessageShow = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.new_puzzle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _createGame(context, PuzzleType.number),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(99),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.number,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _createGame(context, PuzzleType.image),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(99),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.image,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _isCreateSuccessMessageShow
              ? AppLocalizations.of(context)!.create_success
              : "",
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Future<void> _createGame(BuildContext context, PuzzleType puzzleType) async {
    await context.read<PuzzleListCubit>().create(puzzleType);
    setState(() => _isCreateSuccessMessageShow = true);
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isCreateSuccessMessageShow = false);
      }
    });
  }
}
