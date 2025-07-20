import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'providers/breed_provider.dart';

void main() {
  runApp(const CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => BreedProvider())],
      child: MaterialApp(
        title: 'Lovely Cats',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          scaffoldBackgroundColor: Colors.grey.shade50,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(fontSize: 16),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}
