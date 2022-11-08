import 'package:mini_project_alterra/data/datasources/movie_local_data_source.dart';
import 'package:mini_project_alterra/data/datasources/movie_remote_data_source.dart';
import 'package:mini_project_alterra/data/db/database_catatan.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project_alterra/data/db/database_helper.dart';
import 'package:mini_project_alterra/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  DatabaseHelperReview,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}