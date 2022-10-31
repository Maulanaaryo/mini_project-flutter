import 'package:flutter/material.dart';
import 'package:mini_project_alterra/injection.dart' as di;
import 'package:mini_project_alterra/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/providers/movie_top_provider.dart';
import 'package:mini_project_alterra/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MoviePopularProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieTopRatedProvider>(),
        ),
      ],
      child: MaterialApp(
        home: const HomeMovieScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case 'home':
              return MaterialPageRoute(builder: (_) => const HomeMovieScreen());
          }
          return null;
        },
      ),
    );
  }
}
