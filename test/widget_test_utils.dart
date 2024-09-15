import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

typedef Callback = void Function(MethodCall call);

extension WidgetTesterExtension on WidgetTester {
  Future<void> givenView(
    Widget widget, {
    List<NavigatorObserver>? navigatorObservers,
    GlobalKey<NavigatorState>? navigatorKey,
  }) async {
    await pumpWidget(MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorObservers: navigatorObservers ?? [],
      onGenerateRoute: (settings) => StubRoute(settings),
      home: widget,
    ));
  }
}

class StubRoute extends MaterialPageRoute {
  StubRoute(RouteSettings settings)
      : super(
          settings: settings,
          builder: (context) => const SizedBox(),
        );
}

AppLocalizations get l10n => AppLocalizationsEn();
