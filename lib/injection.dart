import 'package:get_it/get_it.dart';

import 'package:mini_project_alterra/data/datasources/movie_local_data_source.dart';
import 'package:mini_project_alterra/data/datasources/movie_remote_data_source.dart';
import 'package:mini_project_alterra/data/db/database_helper.dart';
import 'package:mini_project_alterra/data/repositories/movie_repositories.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';
import 'package:mini_project_alterra/domain/usescases/get_now_playing.dart';

import 'package:http/http.dart' as http;
import 'package:mini_project_alterra/domain/usescases/get_popular.dart';
import 'package:mini_project_alterra/domain/usescases/get_top_rated.dart';
import 'package:mini_project_alterra/providers/movie_list_provider.dart';
import 'package:mini_project_alterra/providers/movie_popular_provider.dart';
import 'package:mini_project_alterra/providers/movie_top_provider.dart';

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
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieTopRatedProvider(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));

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
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());

  // external
  locator.registerLazySingleton(() => http.Client());
}
