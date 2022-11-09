import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/common/utils.dart';
import 'package:mini_project_alterra/presentation/providers/movie_watchlist_provider.dart';
import 'package:mini_project_alterra/widgets/custom_watchlist.dart';
import 'package:provider/provider.dart';

class WatchlistMovieScreen extends StatefulWidget {
  static const routeName = '/watchlist';
  const WatchlistMovieScreen({super.key});

  @override
  State<WatchlistMovieScreen> createState() => _WatchlistMovieScreenState();
}

class _WatchlistMovieScreenState extends State<WatchlistMovieScreen>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<MovieWatchlistProvider>(context, listen: false)
          .fetchWatchlistMovies();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    Provider.of<MovieWatchlistProvider>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MovieWatchlistProvider>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.moviesWatchlist[index];
                  return MovieCard(movie);
                },
                itemCount: data.moviesWatchlist.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
