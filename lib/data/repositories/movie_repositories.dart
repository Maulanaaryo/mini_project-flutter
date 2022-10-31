import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mini_project_alterra/common/exception.dart';
import 'package:mini_project_alterra/common/failure.dart';
import 'package:mini_project_alterra/data/datasources/movie_local_data_source.dart';
import 'package:mini_project_alterra/data/datasources/movie_remote_data_source.dart';
import 'package:mini_project_alterra/domain/entities/movie.dart';
import 'package:mini_project_alterra/domain/entities/movie_detail.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }


  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await remoteDataSource.getPopularMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await remoteDataSource.getTopRatedMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }
}
