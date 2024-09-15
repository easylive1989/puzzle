import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/bloc/current_puzzle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayingTimeView extends StatefulWidget {
  const PlayingTimeView({
    super.key,
    required this.puzzle,
  });

  final CurrentPuzzle puzzle;

  @override
  State<PlayingTimeView> createState() => _PlayingTimeViewState();
}

class _PlayingTimeViewState extends State<PlayingTimeView>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  late Duration _playingTime = widget.puzzle.getPlayingTime(clock.now());

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) => setState(() {
          _playingTime = widget.puzzle.getPlayingTime(clock.now());
        }));
    _ticker?.start();
  }

  @override
  void dispose() {
    _ticker?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formatDuration = _formatPlayingTime(_playingTime);
    return Text(
      AppLocalizations.of(context)!.playing_time(formatDuration),
      style: const TextStyle(fontSize: 20),
    );
  }


  String _formatPlayingTime(Duration duration) {
    final totalSeconds = duration.inSeconds;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    var oneHundredHours = 100 * 60 * 60;

    if (totalSeconds >= oneHundredHours) {
      return '99:59:59';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

}
