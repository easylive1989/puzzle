import 'dart:async';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_zh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

String get localhost =>  Platform.isIOS ? "localhost" : "10.0.2.2";

AppLocalizations get l10n => Platform.isIOS ? AppLocalizationsZh() : AppLocalizationsEn();

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpUntilFound(Finder finder) async {
    const timeout = Duration(seconds: 10);
    final timer = Timer( timeout, () {
      throw TimeoutException("Pump until has timed out");
    });
    while (any(finder) != true) {
      await pump(const Duration(milliseconds: 100));
    }
    timer.cancel();
  }
}
