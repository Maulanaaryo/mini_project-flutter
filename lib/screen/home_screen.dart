import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/constants.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class HomeMovieScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeMovieScreen({super.key});

  @override
  State<HomeMovieScreen> createState() => _HomeMovieScreenState();
}

class _HomeMovieScreenState extends State<HomeMovieScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<MovieListProvider>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(''),
              ),
              accountName: Text('Maulana Aryo'),
              accountEmail: Text('aryo@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Scheduling Movie'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('Dark Theme'),
              onTap: () {
                customDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_sharp),
              title: const Text('Watchlist'),
              onTap: () {},
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Movie',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<MovieListProvider>(
                builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    List<Movie> result = data.nowPlayingMovies;
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: result.length,
                          itemBuilder: (context, index, realIndex) {
                            Movie movie = result[index];
                            return GestureDetector(
                              onTap: () {
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$baseImageUrl${movie.posterPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15,
                                      left: 10,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 20, sigmaY: 20),
                                        child: Text(
                                          movie.title!.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        )
                      ],
                    );
                  } else if (state == RequestState.Error) {
                    return Center(
                      child: Text(
                        data.message,
                        key: const Key('error'),
                      ),
                    );
                  } else {
                    return const Text('There is an error');
                  }
                },
              ),
              _buildSubHeading(title: 'Popular Movies', onTap: () => {}
                  // Navigator.pushNamed(context, PopularMoviesPage.routeName),
                  ),
              Consumer<MovieListProvider>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else if (state == RequestState.Error) {
                  return Center(
                    child: Text(
                      data.message,
                      key: const Key('error'),
                    ),
                  );
                } else {
                  return const Text('There is an error');
                }
              }),
            ],
          ),
        ),
      );
    });
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: kHeading6,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
