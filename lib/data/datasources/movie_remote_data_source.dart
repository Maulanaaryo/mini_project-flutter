import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_project_alterra/common/exception.dart';
import 'package:mini_project_alterra/data/models/movie_detail_model.dart';
import 'package:mini_project_alterra/data/models/movie_model.dart';
import 'package:mini_project_alterra/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getDetailMovies(int id);
  Future<MovieDetailResponse> getYoutubeId(int id);
  Future<List<MovieModel>> getRecommendationsMovies(int id);
  Future<List<MovieModel>> searchMovies(String query);
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
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getDetailMovies(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));
    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getRecommendationsMovies(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getYoutubeId(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/$id/videos?$apiKey'));
    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
