import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alterra/common/constants.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/presentation/screen/detail_screen.dart';
import 'package:mini_project_alterra/presentation/screen/popular_screen.dart';
import 'package:mini_project_alterra/presentation/screen/search_screen.dart';
import 'package:mini_project_alterra/widgets/movie_card_list.dart';
import 'package:mini_project_alterra/widgets/drawer_list.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'MOVIES',
          style: kHeading2,
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: kTertiaryTextColor,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const SearchMovieScreen();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final tween = Tween(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: kTertiaryTextColor,
            ),
          ),
        ],
      ),
      drawer: const DrawerCard(),
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
            children: [
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
                                Navigator.pushNamed(
                                  context,
                                  DetailMovieScreen.routeName,
                                  arguments: movie.id,
                                );
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
              _buildSubHeading(
                  title: 'Popular Movies',
                  onTap: () => {
                        Navigator.pushNamed(
                            context, PopularMovieScreen.routeName),
                      }),
              Consumer<MovieListProvider>(
                builder: (context, data, child) {
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
                },
              ),
              _buildSubHeading(
                  title: 'Top Rated Movies',
                  onTap: () => {
                        Navigator.pushNamed(
                            context, PopularMovieScreen.routeName),
                      }),
              Consumer<MovieListProvider>(
                builder: (context, data, child) {
                  final state = data.topRatedState;
                  if (state == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return MovieList(data.topRatedMovies);
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
            style: kHeading1,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ],
    );
  }
}