import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:mini_project_alterra/data/datasources/movie_local_data_source.dart';
import 'package:mini_project_alterra/data/datasources/movie_remote_data_source.dart';
import 'package:mini_project_alterra/data/db/database_catatan.dart';
import 'package:mini_project_alterra/data/db/database_helper.dart';
import 'package:mini_project_alterra/data/repositories/movie_repositories.dart';
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart';
import 'package:mini_project_alterra/presentation/providers/movie_detail_provider.dart';
import 'package:mini_project_alterra/presentation/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/presentation/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/presentation/providers/movie_review.dart';
import 'package:mini_project_alterra/presentation/providers/movie_search.dart';
import 'package:mini_project_alterra/presentation/providers/movie_top_provider.dart';
import 'package:mini_project_alterra/presentation/providers/movie_watchlist_provider.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListProvider(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MoviePopularProvider(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieTopRatedProvider(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailProvider(
      getDetailMovies: locator(),
      getRecommendationsMovie: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistProvider(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MoviesearchProvider(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieReviewProvider(),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetDetailMovies(locator()));
  locator.registerLazySingleton(() => GetRecommendationsMovie(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // database helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperReview>(
      () => DatabaseHelperReview());
      
  // external
  locator.registerLazySingleton(() => http.Client());
}
