import 'package:dartz/dartz.dart';
import 'package:mini_project_alterra/common/failure.dart';
import 'package:mini_project_alterra/domain/entities/movie_detail.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}