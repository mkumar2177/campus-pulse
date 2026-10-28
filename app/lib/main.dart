import 'package:flutter/material.dart';
import 'data/local_repository.dart';
import 'presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = LocalRepository();
  await repository.initialize();
  runApp(CampusPulseApp(repository: repository));
}
