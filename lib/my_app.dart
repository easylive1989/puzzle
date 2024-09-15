import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:puzzle/puzzle/presentation/play_puzzle/view/play_puzzle_page.dart';
import 'package:puzzle/puzzle/presentation/puzzle_list/view/puzzle_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: PuzzleListPage.route,
      routes: _getRoutes(),
    );
  }

  Map<String, WidgetBuilder> _getRoutes() {
    return {
      PlayPuzzlePage.route: (context) => PlayPuzzlePage(
            id: ModalRoute.of(context)!.settings.arguments as int,
          ),
      PuzzleListPage.route: (context) => const PuzzleListPage(),
    };
  }
}
