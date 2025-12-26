import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_chat/data/datasources/chat_remote_data_source.dart';
import 'package:mini_chat/data/repositories/chat_repository_impl.dart';
import 'package:mini_chat/domain/usecases/fetch_random_message.dart';
import 'package:mini_chat/domain/usecases/fetch_word_meaning.dart';
import 'package:mini_chat/domain/usecases/get_users.dart';
import 'package:mini_chat/screens/main_screen.dart';
import 'package:mini_chat/services/chat_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final client = http.Client();
  final remoteDataSource = ChatRemoteDataSourceImpl(client: client);
  final repository = ChatRepositoryImpl(remoteDataSource: remoteDataSource);
  final fetchRandomMessage = FetchRandomMessage(repository);
  final getUsers = GetUsers(repository);
  final fetchWordMeaning = FetchWordMeaning(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            fetchRandomMessage: fetchRandomMessage,
            getUsers: getUsers,
            fetchWordMeaning: fetchWordMeaning,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void updateTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          surfaceContainerHighest: Color(0xFFF1F3F4), // tab background
        ),
      ),

      // Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          onPrimary: Colors.black,
          surface: Color(0xFF1E1E1E),
          onSurface: Colors.white70,
          surfaceContainerHighest: Color(0xFF2A2A2A), // tab background
        ),
      ),
      home: MainScreen(themeMode: _themeMode, onThemeChanged: updateTheme),
    );
  }
}
