import 'package:dartz/dartz.dart';
import 'package:mini_project_alterra/common/failure.dart';
import 'package:mini_project_alterra/domain/entities/movie_detail.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';

class GetDetailMovies {
  final MovieRepository repository;

  GetDetailMovies(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getDetailMovies(id);
  }
}
