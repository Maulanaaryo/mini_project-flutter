import 'package:flutter/foundation.dart';
import 'package:mini_project_alterra/common/state_enum.dart';
import 'package:mini_project_alterra/data/entities/movie.dart';
import 'package:mini_project_alterra/presentation/repositories/movie_repository.dart';

class MoviePopularProvider extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  MoviePopularProvider({required this.getPopularMovies});

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _movie = data;
        notifyListeners();
      },
    );
  }
}
