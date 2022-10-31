import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_project_alterra/common/exception.dart';
import 'package:mini_project_alterra/data/models/movie/movie_model.dart';
import 'package:mini_project_alterra/data/models/movie/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const apiKey = 'api_key=d29ee1be9469b67855e4d2dc664c2e80';
  static const baseUrl = 'https://api.themoviedb.org/3';
  
  final http.Client client;
  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } 
    else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await client.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    }
    else {
      throw ServerException();
    }
  }
}
