import 'package:dartz/dartz.dart';
import 'package:mini_project_alterra/common/failure.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
}