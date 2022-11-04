import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/widgets/custom_list.dart';
import 'package:provider/provider.dart';

class PopularMovieScreen extends StatefulWidget {
  static const routeName = '/popular-movie';
  const PopularMovieScreen({super.key});

  @override
  State<PopularMovieScreen> createState() => _PopularMovieScreenState();
}

class _PopularMovieScreenState extends State<PopularMovieScreen> {
  @override
  void initState() {
    Future.microtask(
        () => Provider.of<MoviePopularProvider>(context, listen: false).fetchPopularMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MoviePopularProvider>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movie[index];
                  return MovieCard(movie);
                },
                itemCount: data.movie.length,
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
