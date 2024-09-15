import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:puzzle/dependency_providers.dart';
import 'package:puzzle/firebase_options.dart';
import 'package:puzzle/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: DependencyProviders.get(),
    child: const MyApp(),
  ));
}

