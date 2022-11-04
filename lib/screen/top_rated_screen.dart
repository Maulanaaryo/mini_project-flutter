import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/providers/movie_top_provider.dart';
import 'package:mini_project_alterra/widgets/custom_list.dart';
import 'package:provider/provider.dart';

class TopRatedMovieScreen extends StatefulWidget {
  static const routeName = '/top-rated-movie';
  const TopRatedMovieScreen({super.key});

  @override
  State<TopRatedMovieScreen> createState() => _TopRatedMovieScreenState();
}

class _TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<MovieTopRatedProvider>(context, listen: false)
          .fetchTopRatedMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MovieTopRatedProvider>(
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
