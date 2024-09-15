import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaveButton extends StatelessWidget {
  const LeaveButton({
    super.key,
    required this.isGameOver,
  });

  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
        side: WidgetStateProperty.all(
          const BorderSide(color: Colors.black),
        ),
        overlayColor: WidgetStateProperty.all(
          Colors.black12,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(
          Colors.black,
        ),
      ),
      onPressed: () async => Navigator.of(context).pop(isGameOver),
      child: Text(
        isGameOver ? AppLocalizations.of(context)!.finish_game :
        AppLocalizations.of(context)!.leave,
      ),
    );
  }
}
