import 'package:provider/provider.dart';
import 'package:puzzle/dependency_providers.dart';
import 'package:puzzle/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: DependencyProviders.get(),
    child: const MyApp(),
  ));
}

