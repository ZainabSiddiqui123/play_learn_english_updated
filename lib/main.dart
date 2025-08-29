import 'package:flutter/material.dart';
import 'package:play_learn_english/screens/quiz_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/alphabets_screen.dart';
import 'screens/words_screen.dart';
import 'screens/games_screen.dart';
import 'screens/guess_alphabet_game.dart';
import 'screens/match_word_game.dart';
import 'screens/find_color_game.dart';
import 'screens/memory_game.dart';
import 'audio_test.dart'; 
import 'screens/stories_screen.dart'; // <-- yeh line add karo

void main() {
  runApp(const PlayLearnApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play and Learn',
      home: AudioTest(), // Change this line
    );
  }
}

class PlayLearnApp extends StatelessWidget {
  const PlayLearnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Play & Learn English',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F8FF),
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/alphabets': (context) => const AlphabetsScreen(),
        '/words': (context) => const WordsScreen(),
        '/games': (context) => const GamesScreen(),
        '/guess-alphabet': (context) => const GuessAlphabetScreen(),
        '/match-word': (context) => const MatchWordGame(),
        '/find-color': (context) => const FindColorGame(),
        '/memory-game': (context) => const MemoryGame(),
        '/stories': (context) => StoriesScreen(), // <-- yeh line add karo
        '/quiz': (context) => const QuizScreen(),
      },
    );
  }
}