import 'package:dartz/dartz.dart';
import 'package:mini_project_alterra/common/failure.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';

class GetRecommendationsMovie {
  final MovieRepository repository;

  GetRecommendationsMovie(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getRecommendationsMovies(id);
  }
}