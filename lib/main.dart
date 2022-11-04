import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/utils.dart';
import 'package:mini_project_alterra/injection.dart' as di;
import 'package:mini_project_alterra/providers/movie_detail_provider.dart';
import 'package:mini_project_alterra/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/providers/movie_search.dart';
import 'package:mini_project_alterra/providers/movie_top_provider.dart';
import 'package:mini_project_alterra/providers/movie_watchlist_provider.dart';
import 'package:mini_project_alterra/screen/detail_screen.dart';
import 'package:mini_project_alterra/screen/home_screen.dart';
import 'package:mini_project_alterra/screen/popular_screen.dart';
import 'package:mini_project_alterra/screen/search_screen.dart';
import 'package:mini_project_alterra/screen/splash_screen.dart';
import 'package:mini_project_alterra/screen/top_rated_screen.dart';
import 'package:mini_project_alterra/screen/watchlist_screen.dart';
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
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieWatchlistProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MoviesearchProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const SplashScreen(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomeMovieScreen(),
              );
            case PopularMovieScreen.routeName:
              return CupertinoPageRoute(
                builder: (_) => const PopularMovieScreen(),
              );
            case TopRatedMovieScreen.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMovieScreen(),
              );
            case SearchMovieScreen.routeName:
              return CupertinoPageRoute(
                builder: (_) => const SearchMovieScreen(),
              );
            case WatchlistMovieScreen.routeName:
              return CupertinoPageRoute(
                builder: (_) => const WatchlistMovieScreen(),
              );
            case DetailMovieScreen.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => DetailMovieScreen(id: id),
                  settings: settings);
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page cannot be displayed :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
