import 'package:flutter/material.dart';
import 'package:notes_app_cetoribio/provider/note_provider.dart';
import 'package:notes_app_cetoribio/screens/splash_screen.dart';
import 'package:notes_app_cetoribio/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await createDatabase(); // start database
  runApp(
    Provider<Database>(
      create: (context) => database,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOTES APP',
      home: const SplashScreen(),
      routes: {
        '/home': (context) => ChangeNotifierProvider(
              create: (context) => NoteProvider(
                  db: Provider.of<Database>(context, listen: false)),
              child: const HomeScreen(),
            ),
      },
    );
  }
}
